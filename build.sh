#!/bin/bash

set -e

PN="${BASH_SOURCE[0]##*/}"
PD="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source "${PD}/config.sh.sample"
[ -f "${PD}/config.sh" ] && source "${PD}/config.sh"

function usage() {
	cat <<EOF
Usage: ${PN} [Options] [Images ...] [Image:Tag]
Options:
  -h       : show this help message
  -r       : rebuild all existed images

Image:Tag, ex: ubuntu:stable, ex: ubuntu/stable, ex: ubuntu/stable/
EOF
	[ $# -gt 0 ] && { echo ; echo "$@" ; exit 1 ; }
	exit 0
}

if [ "$(id -u)" -gt 0 ] ; then
	sudo="sudo"
else
	sudo=""
fi

if type docker &>/dev/null ; then
	docker="${sudo} docker"
elif type docker.io &>/dev/null ; then
	docker="${sudo} docker.io"
else
	echo "docker command not found"
	exit 1
fi

export DOCKER_BASE="${DOCKER_BASE%%/}"

type getopt cat wget sha1sum md5sum >/dev/null

opt="$(getopt -o hrl -- "$@")" || usage "Parse options failed"

eval set -- "${opt}"
while true ; do
	case "${1}" in
	-h) usage ; shift ;;
	-r) FLAG_REBUILD="1" ; shift ;;
	-l) FLAG_LIST="1" ; shift ;;
	--) shift ; break ;;
	*) echo "Internal error!" ; exit 1 ;;
	esac
done

function check_copy_file() {
	local filename="${1}"
	local localfile

	[ -s "${filename}" ] && return 0

	localfile="$(find "${PD}" -iname "${filename}" ! -empty -print -quit)"

	if [ "${localfile}" ] ; then
		cp -aL "${localfile}" "${filename}"
	fi

	if [ -s "${filename}" ] ; then
		return 0
	else
		return 1
	fi
}

function cat_one_file() {
	local f
	for f in "$@" ; do
		if [ -f "${f}" ] ; then
			if [ "${f:0:${#PD}}" == "${PD}" ] ; then
				echo "# ${f:${#PD}+1}"
			else
				echo "# ${f}"
			fi
			cat "${f}"
			return
		fi
	done
}

function cat_parent_docker_file() {
	local parent_buildpath="$(grep "^FROM ${DOCKER_BASE}/" Dockerfile | cut -c$((${#DOCKER_BASE} + 7))- | sed 's/[\.:]/\//g')"
	local parent_docker="${PD}/${parent_buildpath}"
	local curdir="${PWD}"
	local f

	[ -z "${parent_buildpath}" ] && return
	[ ! -d "${parent_docker}" ] && return
	[ "${parent_docker%%/}" == "${PD%%/}" ] && return

	pushd "${parent_docker}" >/dev/null
	if [ "${curdir}" != "${PWD}" ] ; then

		for f in "$@" ; do
			cat_one_file "${PWD}/${f}"
		done

		cat_parent_docker_file "$@"

	fi
	popd >/dev/null
}

function cat_inherit() {
	local buildpath="${1%%/}"
	local inherit
	if [ -f "${PD}/${buildpath}/inherit" ] ; then
		while read inherit ; do
			if [ ! -d "${PD}/${inherit}" ] ; then
				echo "${buildpath} find invalid inherit: ${inherit}" >&2
				exit 1
			fi
			cat_inherit "${inherit}"
			echo "${inherit}"
		done <<<"$(sed -n '/^\s*[^#]/p' "${PD}/${buildpath}/inherit")"
	fi
}

function process_download_file() {
	local folder="${1%%/}"
	[ "${folder:0:1}" != "/" ] && folder="${PD}/${folder}"

	pushd "${folder}" >/dev/null
	# download if need
	if [ -s download ] ; then
		while read line ; do
			filename="$(awk '{print $1}' <<<"${line}")"
			url="$(awk '{print $2}' <<<"${line}")"
			if ! check_copy_file "${filename}" ; then
				wget -O "${filename}" "${url}"
			fi
		done <<<"$(sed -n '/^\s*[^#]/p' "download")"
	fi

	# checksum if need
	if [ -s sha1sum ] ; then
		sha1sum -c sha1sum
	fi
	if [ -s md5sum ] ; then
		md5sum -c md5sum
	fi
	popd >/dev/null
}

function build() {
	local buildpath="${1%%/}"
	local imgpath="${buildpath%/*}"
	local fullimgtag="$(echo "${buildpath}" | sed -r 's/\/([^/]*?)$/:\1/' | sed 's/\//./g')"
	local imgname="${fullimgtag%:*}"
	local tag="${fullimgtag##*:}"
	local line
	local filename
	local url
	local parent_imgpath
	local parent_imgname
	local parent_tag
	local auto_apt_get
	local dev_mode
	local inherit
	local old_imgid

	if ( [ "${tag}" == "dev" ] || [ "${tag:${#tag}-4}" == "-dev" ] ) && [ ! -d "${PD}/${buildpath}" ] ; then
		if [ "${tag}" == "dev" ] ; then
			parent_tag="latest"
		else
			parent_tag="${tag:0:${#tag}-4}"
		fi

		if [ ! -f "${PD}/${imgpath}/${parent_tag}/Dockerfile" ] ; then
			echo "${buildpath} is invalid package" >&2
			exit 1
		fi

		# reset tmp directory
		rm -rf "${PD}/tmp/${buildpath}"
		mkdir -p "${PD}/tmp/${buildpath}"

		pushd "${PD}/tmp/${buildpath}" >/dev/null
		cp -a "${PD}/${imgpath}/${parent_tag}/Dockerfile" "./"
		sed -i "s/^FROM .*$/FROM DOCKER_BASE\/${imgname}:${parent_tag}/" "Dockerfile"
		if [ -z "$(grep "^EXPOSE 22$" "Dockerfile")" ] ; then
			echo "EXPOSE 22" >> "Dockerfile"
		fi
		cp -a "${PD}/ubuntu/stable-dev/inherit" "inherit"
		popd >/dev/null
	else
		if [ ! -f "${PD}/${buildpath}/Dockerfile" ] ; then
			echo "${buildpath} is invalid package" >&2
			exit 1
		fi

		process_download_file "${buildpath}"

		# reset tmp directory
		rm -rf "${PD}/tmp/${buildpath}"
		mkdir -p "${PD}/tmp/${buildpath}"
		cp -aL "${PD}/${buildpath}" "${PD}/tmp/${imgpath}/"
	fi

	# change to tmp directory
	pushd "${PD}/tmp/${buildpath}" >/dev/null

	# init Dockerfile part 1
	line="$(sed -n '/^FROM DOCKER_BASE\//p' "Dockerfile")"
	if [ "${line}" ] ; then
		if [ -z "$(grep ":" <<<"${line}")" ] ; then
			line="$(echo "${line}" | sed -r 's/\/([^/]*?)$/:\1/' | sed 's/\//./g' | sed 's/^FROM DOCKER_BASE\./FROM DOCKER_BASE\//')"
			sed -i "/^FROM DOCKER_BASE/c \\${line}" "Dockerfile"
		fi
	fi

	# check parent image exists
	line="$(sed -n 's/^FROM DOCKER_BASE\///p' Dockerfile)"
	if [ "${line}" ] ; then
		parent_imgname="$(cut -d: -f1 <<<"${line}")"
		parent_imgpath="$(echo "${parent_imgname}" | sed 's/\./\//g')"
		parent_tag="$(cut -d: -f2 <<<"${line}")"
		parent_tag="${parent_tag:-latest}"
		if [ "$(grep ":" <<<"${DOCKER_BASE}")" ] ; then
			# update parent image by docker pull if in private registory
			${docker} pull "${DOCKER_BASE}/${parent_imgname}:${parent_tag}"
		fi
		if [ -z "$(${docker} images "${DOCKER_BASE}/${parent_imgname}" | sed "1d" | awk '{print $2}' | grep "^${parent_tag}\$")" ] ; then
			build "${parent_imgpath}/${parent_tag}"
		fi
	fi

	# init Dockerfile part 2
	sed -i "/^ENV DOCKER_SRC$/c \\ENV DOCKER_SRC /opt/docker/DOCKER_BASE/${buildpath}" "Dockerfile"
	sed -i "/^RUN$/c \\RUN bash --login \$DOCKER_SRC/build-all.sh" "Dockerfile"
	sed -i "/^CMD$/c \\CMD bash --login \$DOCKER_SRC/start-all.sh" "Dockerfile"
	sed -i "/^ENTRYPOINT$/c \\ENTRYPOINT [\"/bin/bash\", \"--login\", \"/opt/docker/DOCKER_BASE/${buildpath}/start-all.sh\"]" "Dockerfile"
	sed -i "s|DOCKER_BASE|${DOCKER_BASE}|g" "Dockerfile"

	# generate root ssh key file
	if [ "${ROOT_PUBKEY}" ] ; then
		mkdir -p "root/root/.ssh"
		for filename in ${ROOT_PUBKEY} ; do
			cat "${filename}" >> root/root/.ssh/authorized_keys
		done
		chmod 600 root/root/.ssh/authorized_keys
	fi

	# check inherit of inherit
	echo "Checking inherit list ..."
	cat_inherit "${parent_imgpath}/${parent_tag}" | awk '!a[$0]++' > pinherit
	cat_inherit "${buildpath}" | awk '!a[$0]++' > inherit

	# process inherit function
	while read inherit ; do
		# process inherit download file
		cat_one_file "${PD}/${inherit}/download" >> "download"
		cat_one_file "${PD}/${inherit}/sha1sum" >> "sha1sum"
		cat_one_file "${PD}/${inherit}/md5sum" >> "md5sum"

		# copy inherit root file
		if [ -d "${PD}/${inherit}/root" ] ; then
			cp -aL "${PD}/${inherit}/root" ./
		fi
	done <<<"$(cat_one_file "inherit")"
	sed -i '/^\s*$/d;/^\s*#/d' "download"
	sed -i '/^\s*$/d;/^\s*#/d' "sha1sum"
	sed -i '/^\s*$/d;/^\s*#/d' "md5sum"
	process_download_file "${PD}/tmp/${buildpath}"

	# check necessary to auto apt-get update and clean
	if [ "$(cat_one_file "build.sh" | grep "^[[:space:]]*apt-get ")" ] ; then
		auto_apt_get="true"
	else
		auto_apt_get=""
	fi
	if [ -z "${auto_apt_get}" ] ; then
		while read inherit ; do
			if [ "$(cat_one_file "${PD}/${inherit}/build.sh" | grep "^[[:space:]]*apt-get ")" ] ; then
				auto_apt_get="true"
				break
			fi
		done <<<"$(cat_one_file "inherit")"
	fi

	# check dev suffix
	if [ "${buildpath}" == "ubuntu/12.04-dev" ] ; then
		dev_mode=""
	elif [ "${buildpath}" == "ubuntu/stable-dev" ] ; then
		dev_mode=""
	elif [ "${tag}" == "dev" ] || [ "${tag:${#tag}-4}" == "-dev" ] ; then
		dev_mode="true"
		auto_apt_get="true"
	else
		dev_mode=""
	fi

	# generate build-all.sh
	echo "set -e" > build-all.sh
	chmod +x build-all.sh
	cat_one_file "${PD}/config.sh.sample" >> build-all.sh
	cat_one_file "${PD}/config.sh" >> build-all.sh
	cat_one_file "config.sh" >> build-all.sh
	cat_one_file "build-pre.sh" "${PD}/ubuntu/stable/build-pre.sh" >> build-all.sh
	if [ "${auto_apt_get}" ] ; then
		echo '# auto_apt_get' >> build-all.sh
		echo 'apt-get -q update' >> build-all.sh
	fi
	while read inherit ; do
		cat_one_file "${PD}/${inherit}/build.sh" >> build-all.sh
	done <<<"$(cat_one_file "inherit")"
	cat_one_file "build.sh" >> build-all.sh
	if [ "${dev_mode}" ] ; then
		cat_one_file "${PD}/ubuntu/stable-dev/build.sh" >> build-all.sh
	fi
	if [ "${auto_apt_get}" ] ; then
		echo '# auto_apt_get' >> build-all.sh
		echo 'apt-get -q clean' >> build-all.sh
	fi
	cat_one_file "build-post.sh" "${PD}/ubuntu/stable/build-post.sh" >> build-all.sh

	# generate test-all.sh
	echo "set -e" > test-all.sh
	chmod +x test-all.sh
	cat_one_file "${PD}/config.sh.sample" >> test-all.sh
	cat_one_file "${PD}/config.sh" >> test-all.sh
	cat_one_file "config.sh" >> test-all.sh
	cat_one_file "test-pre.sh" "${PD}/ubuntu/stable/test-pre.sh" >> test-all.sh
	cat_parent_docker_file "test.sh" >> test-all.sh
	while read inherit ; do
		cat_one_file "${PD}/${inherit}/test.sh" >> test-all.sh
	done <<<"$(cat_one_file "pinherit")"
	while read inherit ; do
		cat_one_file "${PD}/${inherit}/test.sh" >> test-all.sh
	done <<<"$(cat_one_file "inherit")"
	cat_one_file "test.sh" >> test-all.sh
	if [ "${dev_mode}" ] ; then
		cat_one_file "test.sh" "${PD}/ubuntu/stable-dev/test.sh" >> test-all.sh
	fi
	cat_one_file "test-post.sh" "${PD}/ubuntu/stable/test-post.sh" >> test-all.sh

	# generate start-all.sh
	echo "set -e" > start-all.sh
	chmod +x start-all.sh
	cat_one_file "${PD}/config.sh.sample" >> start-all.sh
	cat_one_file "${PD}/config.sh" >> start-all.sh
	cat_one_file "config.sh" >> start-all.sh
	cat_one_file "start-pre.sh" "${PD}/ubuntu/stable/start-pre.sh" >> start-all.sh
	cat_parent_docker_file "start.sh" >> start-all.sh
	while read inherit ; do
		cat_one_file "${PD}/${inherit}/start.sh" >> start-all.sh
	done <<<"$(cat_one_file "pinherit")"
	while read inherit ; do
		cat_one_file "${PD}/${inherit}/start.sh" >> start-all.sh
	done <<<"$(cat_one_file "inherit")"
	cat_one_file "start.sh" >> start-all.sh
	if [ "${dev_mode}" ] ; then
		cat_one_file "${PD}/ubuntu/stable-dev/start.sh" >> start-all.sh
	fi
	cat_one_file "start-post.sh" "${PD}/ubuntu/stable/start-post.sh" >> start-all.sh

	# check if image is used, then tag it with another name before new building
	if [ "$(${docker} ps -a | sed "1d" | awk '{print $2}' | grep "^${DOCKER_BASE}/${imgname}:${tag}$")" ] ; then
		old_imgid="$(${docker} images "${DOCKER_BASE}/${imgname}" | sed "1d" | grep "^${DOCKER_BASE}/${imgname}\\s\\+${tag}\\s" | awk '{print $3}')"
		${docker} tag "${old_imgid}" "${DOCKER_BASE}/${imgname}:${tag}-$(date "+%Y%m%d-%H%M%S")"
	fi

	${docker} build -t "${DOCKER_BASE}/${imgname}:${tag}" .

	# push to private registory
	if [ "$(grep ":" <<<"${DOCKER_BASE}")" ] ; then
		${docker} push "${DOCKER_BASE}/${imgname}:${tag}"
	fi

	popd >/dev/null
}

function rebuild() {
	echo "Collecting current images info ..."
	local images="$(${docker} images | sed "1d" | grep "^${DOCKER_BASE}/" | awk '{print $1"/"$2}' | cut -c$((${#DOCKER_BASE} + 2))- | sed "s/\./\\//g")"
	local imagesnum="$(wc -l <<<"${images}")"
	local buildpath
	local tailpath
	local parent_imgpath
	local i

	pushd "${PD}" >/dev/null
	for ((i=imagesnum ; i>=1 ; i--)) ; do
		buildpath="$(sed -n "${i}p" <<<"${images}")"
		if [ ! -d "${buildpath}" ] ; then
			tailpath="${buildpath:${#buildpath}-4}"
			if [ "${tailpath}" != "-dev" ] && [ "${tailpath}" != "/dev" ] ; then
				continue
			fi
			if [ "${tailpath}" == "-dev" ] ; then
				parent_imgpath="${buildpath:0:-4}"
			elif [ "${tailpath}" == "/dev" ]; then
				parent_imgpath="${buildpath:0:-4}/latest"
			else
				continue
			fi
			if [ ! -d "${parent_imgpath}" ] ; then
				continue
			fi
		fi
		build "${buildpath}"
	done
	popd >/dev/null
}

if [ "${FLAG_LIST}" == "1" ] ; then
	pushd "${PD}" >/dev/null
	find -iname Dockerfile | sed 's|^./||g;s|/Dockerfile$||g;/^tmp\//d'
	popd >/dev/null
elif [ "${FLAG_REBUILD}" == "1" ] ; then
	rebuild
else
	for i in "$@" ; do
		build "${i}"
	done
fi


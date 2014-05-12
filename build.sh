#!/bin/bash

PN="${BASH_SOURCE[0]##*/}"
PD="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source "${PD}/config.sh.sample" || exit $?
[ -f "${PD}/config.sh" ] && source "${PD}/config.sh"

# package list with order, first tag is default
pkglist="$(cat <<EOF
  * ubuntu            stable satble-dev 12.04  12.04-dev  apt-cacher-ng apt-cacher-ng-dev
  +-- java            jre7   jre7-dev   jdk6
    +-- tomcat        7      7-dev      7.0.52 7.0.52-dev
      +-- nexus       2.7.2  2.7.2-dev
    +-- solr          4.7.0  4.7.0-dev  4.6.0  4.6.0-dev
  +-- apache2         php5   php5-dev
    +-- phpvirtualbox 4.3.1  4.3.1-dev
  +-- nginx           latest dev        ppa    ppa-dev
  +-- golang          1.2    1.2-dev    gor    gor-dev
  +-- mysql           latest phpmyadmin dev
  +-- nodejs          ppa    ppa-dev
EOF
)"

function usage() {
	cat <<EOF
Usage: ${PN} [Options] [Images ...] [Image:Tag]
Options:
  -h       : show this help message
  -r       : rebuild all existed images

Images: (default: build all images)
${pkglist}

Image:Tag, ex: ubuntu:stable, ex: ubuntu/stable, ex: ubuntu/stable/
EOF
	[ $# -gt 0 ] && { echo ; echo "$@" ; exit 1 ; } || exit 0
}

if hash docker 2>/dev/null ; then
	docker="docker"
elif hash docker.io 2>/dev/null ; then
	docker="docker.io"
else
	echo "docker command not found"
	exit 1
fi

type getopt cat wget sha1sum md5sum >/dev/null || exit $?

opt="$(getopt -o hr -- "$@")" || usage "Parse options failed"

eval set -- "${opt}"
while true ; do
	case "${1}" in
	-h) usage ; shift ;;
	-r) FLAG_REBUILD="1" ; shift ;;
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
		cp -aL "${localfile}" "${filename}" || exit $?
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
			if [ "${f:0:${#PD}}" == "${PWD}" ] ; then
				echo "# ${f:${#PWD}+1}"
			else
				echo "# ${f}"
			fi
			cat "${f}"
			return
		fi
	done
}

function cat_parent_docker_file() {
	local parent_docker="${PD}/$(sed -n 's/^FROM [^/]\+\///p' Dockerfile | sed 's/:/\//')"
	local curdir="${PWD}"
	local f

	[ ! -d "${parent_docker}" ] && return
	[ "${parent_docker%%/}" == "${PD%%/}" ] && return

	pushd "${parent_docker}" >/dev/null || exit $?
	if [ "${curdir}" != "${PWD}" ] ; then

		for f in "$@" ; do
			cat_one_file "${PWD}/${f}"
		done

		cat_parent_docker_file "$@"

	fi
	popd >/dev/null || exit $?
}

function build() {
	local imgname="${1}" && shift
	local tag
	local line
	local filename
	local url
	local parent_imgname
	local parent_tag
	for tag in "$@" ; do
		pushd "${PD}/${imgname}/${tag}" >/dev/null || exit $?

		# check parent image exists
		line="$(sed -n 's/^FROM\s\+DOCKER_BASE\///p' Dockerfile)"
		if [ "${line}" ] ; then
			parent_imgname="$(cut -d: -f1 <<<"${line}")"
			parent_tag="$(cut -d: -f2 <<<"${line}")"
			parent_tag="${parent_tag:-latest}"
			if [ -z "$(${docker} images "${DOCKER_BASE}/${parent_imgname}" | sed "1d" | awk '{print $2}' | grep "^${parent_tag}\$")" ] ; then
				build "${parent_imgname}" "${parent_tag}" || exit $?
			fi
		fi

		# download if need
		if [ -f download ] ; then
			while read line ; do
				filename="$(awk '{print $1}' <<<"${line}")"
				url="$(awk '{print $2}' <<<"${line}")"
				if ! check_copy_file "${filename}" ; then
					wget -O "${filename}" "${url}"
				fi
			done <<<"$(grep -v "^#" download | grep -v "^[[:space:]]*$")"
		fi

		# checksum if need
		if [ -f sha1sum ] ; then
			sha1sum -c sha1sum || exit $?
		fi
		if [ -f md5sum ] ; then
			md5sum -c md5sum || exit $?
		fi
		popd >/dev/null || exit $?

		# reset tmp directory
		rm -rf "${PD}/tmp/${imgname}/${tag}" || exit $?
		mkdir -p "${PD}/tmp/${imgname}/${tag}" || exit $?
		cp -aL "${PD}/${imgname}/${tag}" "${PD}/tmp/${imgname}/" || exit $?
		sed -i "s/DOCKER_BASE/${DOCKER_BASE}/g" "${PD}/tmp/${imgname}/${tag}/Dockerfile" || exit $?

		# change to tmp directory
		pushd "${PD}/tmp/${imgname}/${tag}" >/dev/null || exit $?

		# generate root ssh key file
		mkdir -p "root/root/.ssh" || exit $?
		for filename in ${ROOT_PUBKEY} ; do
			cat "${filename}" >> root/root/.ssh/authorized_keys || exit $?
		done
		chmod 600 root/root/.ssh/authorized_keys || exit $?

		# generate build-all.sh
		> build-all.sh
		cat_one_file "${PD}/config.sh.sample" >> build-all.sh
		cat_one_file "${PD}/config.sh" >> build-all.sh
		cat_one_file "${PD}/${imgname}/config.sh" >> build-all.sh
		cat_one_file "${PD}/${imgname}/${tag}/config.sh" >> build-all.sh
		cat_one_file "${PD}/${imgname}/${tag}/build-pre.sh" "${PD}/ubuntu/stable/build-pre.sh" >> build-all.sh
		if [ "${imgname}:${tag}" == "ubuntu:12.04-dev" ] ; then
			true
		elif [ "${imgname}:${tag}" == "ubuntu:stable-dev" ] ; then
			true
		elif [ "${tag}" == "dev" ] || [ "${tag:${#tag}-4}" == "-dev" ] ; then
			cat_one_file "${PD}/ubuntu/stable-dev/build.sh" >> build-all.sh
		fi
		cat_one_file "${PD}/${imgname}/${tag}/build.sh" >> build-all.sh
		cat_one_file "${PD}/${imgname}/${tag}/build-post.sh" "${PD}/ubuntu/stable/build-post.sh" >> build-all.sh

		# generate test-all.sh
		> test-all.sh
		cat_one_file "${PD}/config.sh.sample" >> test-all.sh
		cat_one_file "${PD}/config.sh" >> test-all.sh
		cat_one_file "${PD}/${imgname}/config.sh" >> test-all.sh
		cat_one_file "${PD}/${imgname}/${tag}/config.sh" >> test-all.sh
		cat_one_file "${PD}/${imgname}/${tag}/test-pre.sh" "${PD}/ubuntu/stable/test-pre.sh" >> test-all.sh
		if [ "${imgname}:${tag}" == "ubuntu:12.04-dev" ] ; then
			true
		elif [ "${imgname}:${tag}" == "ubuntu:stable-dev" ] ; then
			true
		elif [ "${tag}" == "dev" ] || [ "${tag:${#tag}-4}" == "-dev" ] ; then
			cat_one_file "${PD}/${imgname}/${tag}/test.sh" "${PD}/ubuntu/stable-dev/test.sh" >> test-all.sh
		fi
		cat_parent_docker_file "test.sh" >> test-all.sh
		cat_one_file "${PD}/${imgname}/${tag}/test.sh" >> test-all.sh
		cat_one_file "${PD}/${imgname}/${tag}/test-post.sh" "${PD}/ubuntu/stable/test-post.sh" >> test-all.sh

		# generate start-all.sh
		> start-all.sh
		cat_one_file "${PD}/config.sh.sample" >> start-all.sh
		cat_one_file "${PD}/config.sh" >> start-all.sh
		cat_one_file "${PD}/${imgname}/config.sh" >> start-all.sh
		cat_one_file "${PD}/${imgname}/${tag}/config.sh" >> start-all.sh
		cat_one_file "${PD}/${imgname}/${tag}/start-pre.sh" "${PD}/ubuntu/stable/start-pre.sh" >> start-all.sh
		if [ "${imgname}:${tag}" == "ubuntu:12.04-dev" ] ; then
			true
		elif [ "${imgname}:${tag}" == "ubuntu:stable-dev" ] ; then
			true
		elif [ "${tag}" == "dev" ] || [ "${tag:${#tag}-4}" == "-dev" ] ; then
			cat_one_file "${PD}/ubuntu/stable-dev/start.sh" >> start-all.sh
		fi
		cat_parent_docker_file "start.sh" >> start-all.sh
		cat_one_file "${PD}/${imgname}/${tag}/start.sh" >> start-all.sh
		cat_one_file "${PD}/${imgname}/${tag}/start-post.sh" "${PD}/ubuntu/stable/start-post.sh" >> start-all.sh

		${docker} build -t "${DOCKER_BASE}/${imgname}:${tag}" . || exit $?

		popd >/dev/null || exit $?
	done
}

function rebuild() {
	echo "Collecting current images info ..."
	local images="$(${docker} images | sed '1d' | awk '/^'"${DOCKER_BASE}"'\//{print $1"/"$2}' | cut -d/ -f2-)"
	local pkgline
	local pkgname
	local pkgtag
	local num
	local i

	while read pkgline ; do
		pkgline="$(sed 's/^[*+-]*\s*//' <<<"${pkgline}")"
		num="$(awk '{print NF}' <<<"${pkgline}")"
		pkgname="$(awk '{print $1}' <<<"${pkgline}")"
		for ((i=2 ; i<=num ; i++)) ; do
			pkgtag="$(awk '{print $'"${i}"'}' <<<"${pkgline}")"
			if [ "$(grep "^${pkgname}/${pkgtag}\$" <<<"${images}")" ] ; then
				build "${pkgname}" "${pkgtag}"
			fi
		done
	done <<<"${pkglist}"
}

if [ "${FLAG_REBUILD}" == "1" ] ; then
	rebuild
elif [ $# -eq 0 ] ; then
	while read i ; do
		image="$(awk '{print $1}' <<<"${i}")"
		tag="$(awk '{print $2}' <<<"${i}")"
		build "${image}" "${tag}"
	done <<<"$(sed 's/^[-+* ]*//g' <<<"${pkglist}")"
else
	for i in "$@" ; do
		i="${i%%/}"
		i="$(sed 's/\//:/g' <<<"${i}")"
		if [ "${i##*:}" == "${i}" ] ; then
			tag="$(sed 's/^[-+* ]*//g' <<<"${pkglist}" | grep "^${i}" | awk '{print $2}')"
			build "${i}" "${tag}"
		else
			build "${i%:*}" "${i##*:}"
		fi
	done
fi


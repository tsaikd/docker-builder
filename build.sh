#!/bin/bash

PN="${BASH_SOURCE[0]##*/}"
PD="${BASH_SOURCE[0]%/*}"

[ "${PD}" == "." ] && PD="${PWD}"

source "${PD}/config.sh.sample" || exit $?
[ -f "${PD}/config.sh" ] && source "${PD}/config.sh"

# package list with order, first tag is default
pkglist="$(cat <<EOF
  * ubuntu     12.04  12.04-dev
  +-- java     jre7   jre7-dev  jdk6
    +-- tomcat 7      7-dev     7.0.47 7.0.47-dev
    +-- solr   4.6.0  4.6.0-dev
  +-- nginx    latest dev
  +-- golang   1.2    1.2-dev
EOF
)"

function usage() {
	cat <<EOF
Usage: ${PN} [Options] [Images ...] [Image:Tag]
Options:
  -h       : show this help message
Images: (default: build all images)
${pkglist}
Image:Tag, ex: ubuntu:12.04, ex: ubuntu/12.04, ex: ubuntu/12.04/
EOF
	[ $# -gt 0 ] && { echo ; echo "$@" ; exit 1 ; } || exit 0
}

type getopt cat wget docker >/dev/null || exit $?

opt="$(getopt -o h -- "$@")" || usage "Parse options failed"

eval set -- "${opt}"
while true ; do
	case "${1}" in
	-h) usage ; shift ;;
	--) shift ; break ;;
	*) echo "Internal error!" ; exit 1 ;;
	esac
done

function check_copy_file() {
	local filename="${1}"
	local localfile

	[ -f "${filename}" ] && return 0

	localfile="$(find "${PD}" -iname "${filename}" -print -quit)"

	if [ "${localfile}" ] ; then
		cp -aL "${localfile}" "${filename}" || exit $?
	else
		return 1
	fi
}

function cat_one_file() {
	local f
	for f in "$@" ; do
		if [ -f "${f}" ] ; then
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
			[ -f "${f}" ] && cat "${f}"
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
			if [ -z "$(docker images "${DOCKER_BASE}/${parent_imgname}" | sed "1d" | awk '{print $2}' | grep "^${parent_tag}\$")" ] ; then
				build "${parent_imgname}" "${parent_tag}" || exit $?
			fi
		fi

		# download if need
		if [ -f download ] ; then
			while read line ; do
				filename="$(awk '{print $1}' <<<"${line}")"
				url="$(awk '{print $2}' <<<"${line}")"
				if ! check_copy_file "${filename}" ; then
					wget -O "${filename}" "${url}" || exit $?
				fi
			done <<<"$(grep -v "^#" download | grep -v "^[[:space:]]*$")"
		fi

		# checksum if need
		if [ -f sha1sum ] ; then
			sha1sum -c sha1sum || exit $?
		fi
		popd >/dev/null || exit $?

		# reset tmp directory
		rm -rf "${PD}/tmp/${imgname}/${tag}" || exit $?
		mkdir -p "${PD}/tmp/${imgname}/${tag}" || exit $?
		cp -aL "${PD}/${imgname}/${tag}" "${PD}/tmp/${imgname}/" || exit $?
		sed -i "s/DOCKER_BASE/${DOCKER_BASE}/g" "${PD}/tmp/${imgname}/${tag}/Dockerfile" || exit $?

		# change to tmp directory
		pushd "${PD}/tmp/${imgname}/${tag}" >/dev/null || exit $?

		# generate build-all.sh
		> build-all.sh
		cat_one_file "config.sh.sample" "../../../config.sh.sample" >> build-all.sh
		cat_one_file "config.sh" "../../../config.sh" >> build-all.sh
		cat_one_file "build-pre.sh" "../../../ubuntu/12.04/build-pre.sh" >> build-all.sh
		if [ "${tag}" == "dev" ] || [ "${tag:${#tag}-4}" == "-dev" ] ; then
			cat_one_file "${PD}/ubuntu/12.04-dev/build.sh" >> build-all.sh
		elif [ "${imgname}:${tag}" != "ubuntu:12.04-dev" ] ; then
			cat_one_file "build.sh" >> build-all.sh
		fi
		cat_one_file "build-post.sh" "../../../ubuntu/12.04/build-post.sh" >> build-all.sh

		# generate start-all.sh
		> start-all.sh
		cat_one_file "config.sh.sample" "../../../config.sh.sample" >> start-all.sh
		cat_one_file "config.sh" "../../../config.sh" >> start-all.sh
		cat_one_file "start-pre.sh" "../../../ubuntu/12.04/start-pre.sh" >> start-all.sh
		cat_parent_docker_file "start.sh" >> start-all.sh
		cat_one_file "start.sh" >> start-all.sh
		cat_one_file "start-post.sh" "../../../ubuntu/12.04/start-post.sh" >> start-all.sh

		docker build -t ${DOCKER_BASE}/${imgname}:${tag} -rm . || exit $?

		popd >/dev/null || exit $?
	done
}

if [ $# -eq 0 ] ; then
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


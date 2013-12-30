#!/bin/bash

PN="${BASH_SOURCE[0]##*/}"
PD="${BASH_SOURCE[0]%/*}"

source "${PD}/config.sh.sample" || exit $?
[ -f "${PD}/config.sh" ] && source "${PD}/config.sh"

function usage() {
	cat <<EOF
Usage: ${PN} [Options] [Images ...]
Options:
  -h       : show this help message
Images: (default: build all images)
  ubuntu
  golang
  nginx
  java
  tomcat
EOF
	[ $# -gt 0 ] && { echo ; echo "$@" ; exit 1 ; } || exit 0
}

type getopt cat docker >/dev/null || exit $?

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
	local check_path="${1}" && shift
	local possible_path

	[ -f "${check_path}" ] && return 0

	for possible_path in "$@" ; do
		if [ -f "${possible_path}" ] ; then
			cp -a "${possible_path}" "${check_path}" || exit $?
			return 0
		fi
	done

	return 1
}

function build() {
	local imgname="${1}" && shift
	local tag
	for tag in "$@" ; do
		rm -rf "${PD}/tmp/${imgname}/${tag}" || exit $?
		mkdir -p "${PD}/tmp/${imgname}/${tag}" || exit $?
		cp -a "${PD}/${imgname}/${tag}" "${PD}/tmp/${imgname}/" || exit $?
		sed -i "s/DOCKER_BASE/${DOCKER_BASE}/g" "${PD}/tmp/${imgname}/${tag}/Dockerfile" || exit $?
		pushd "${PD}/tmp/${imgname}/${tag}" >/dev/null || exit $?
		check_copy_file "config.sh" "../../../config.sh" || exit $?
		check_copy_file "build-pre.sh" "../../../ubuntu/build-pre.sh" || exit $?
		check_copy_file "build-post.sh" "../../../ubuntu/build-post.sh" || exit $?
		if [ "${tag}" == "dev" ] ; then
			check_copy_file "build.sh" "../../../ubuntu/dev/build.sh" || exit $?
		fi
		if [ "${imgname}" == "golang" ] && [ "${tag}" == "1.2" ] ; then
			if ! check_copy_file "go1.2.linux-amd64.tar.gz" "../go1.2.linux-amd64.tar.gz" ; then
				wget "https://go.googlecode.com/files/go1.2.linux-amd64.tar.gz" || exit $?
			fi
			sha1sum -c sha1sum || exit $?
		fi
		docker build -t ${DOCKER_BASE}/${imgname}:${tag} -rm . || exit $?
		popd >/dev/null || exit $?
	done
}

if [ $# -eq 0 ] ; then
	build ubuntu 12.04 dev
	build golang 1.2 dev
	build nginx latest dev
	build java jre7
	build tomcat 7 dev
else
	for i in "$@" ; do
		case "${i}" in
		ubuntu) build ${i} 12.04 dev ;;
		golang) build ${i} 1.2 dev ;;
		nginx) build ${i} latest dev ;;
		java) build ${i} jre7 ;;
		tomcat) build ${i} 7 dev ;;
		esac
	done
fi


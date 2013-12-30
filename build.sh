#!/bin/bash

PN="${BASH_SOURCE[0]##*/}"
PD="${BASH_SOURCE[0]%/*}"

function usage() {
	cat <<EOF
Usage: ${PN} [Options] [Images ...]
Options:
  -h       : show this help message
Images: (default: build all images)
  ubuntu
  golang
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

function build_ubuntu() {
	for i in "$@" ; do
		pushd "${PD}/ubuntu/${i}" >/dev/null || exit $?
		case "${i}" in
		12.04)
			docker build -t tsaikd/ubuntu -rm . || exit $?
			docker tag tsaikd/ubuntu tsaikd/ubuntu:12.04 || exit $?
			;;
		dev)
			docker build -t tsaikd/ubuntu:dev -rm . || exit $?
			;;
		esac
		popd >/dev/null || exit $?
	done
}

function build_golang() {
	for i in "$@" ; do
		pushd "${PD}/golang/${i}" >/dev/null || exit $?
		case "${i}" in
		1.2)
			if ! check_copy_file "go1.2.linux-amd64.tar.gz" "../dev/go1.2.linux-amd64.tar.gz" ; then
				wget "https://go.googlecode.com/files/go1.2.linux-amd64.tar.gz" || exit $?
			fi
			sha1sum -c sha1sum || exit $?
			docker build -t tsaikd/golang -rm . || exit $?
			docker tag tsaikd/golang tsaikd/golang:1.2 || exit $?
			;;
		dev)
			if ! check_copy_file "go1.2.linux-amd64.tar.gz" "../1.2/go1.2.linux-amd64.tar.gz" ; then
				wget "https://go.googlecode.com/files/go1.2.linux-amd64.tar.gz" || exit $?
			fi
			sha1sum -c sha1sum || exit $?
			docker build -t tsaikd/golang:dev -rm . || exit $?
			;;
		esac
		popd >/dev/null || exit $?
	done
}

if [ $# -eq 0 ] ; then
	build_ubuntu 12.04 dev
	build_golang 1.2 dev
else
	for i in "$@" ; do
		case "${i}" in
		ubuntu) build_ubuntu 12.04 dev ;;
		golang) build_golang 1.2 dev ;;
		esac
	done
fi


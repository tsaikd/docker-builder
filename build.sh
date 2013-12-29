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

function build_ubuntu() {
	pushd "${PD}/ubuntu" >/dev/null || exit $?

	docker build -t tsaikd/ubuntu -rm . || exit $?
	docker tag tsaikd/ubuntu tsaikd/ubuntu:1204 || exit $?

	popd >/dev/null || exit $?

	pushd "${PD}/ubuntu-dev" >/dev/null || exit $?

	docker build -t tsaikd/ubuntu:dev -rm . || exit $?

	popd >/dev/null || exit $?
}

function build_golang() {
	pushd "${PD}/golang" >/dev/null || exit $?

	if [ ! -f "go1.2.linux-amd64.tar.gz" ] ; then
		wget "https://go.googlecode.com/files/go1.2.linux-amd64.tar.gz" || exit $?
	fi

	sha1sum -c sha1sum || exit $?

	docker build -t tsaikd/golang -rm . || exit $?
	docker tag tsaikd/golang tsaikd/golang:1.2 || exit $?

	popd >/dev/null || exit $?
}

if [ $# -eq 0 ] ; then
	build_ubuntu
	build_golang
else
	for i in "$@" ; do
		case "${i}" in
		ubuntu) build_ubuntu ;;
		golang) build_golang ;;
		esac
	done
fi


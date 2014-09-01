#!/bin/bash

ver="1.3.1"

if ! type go &>/dev/null ; then
	apt-get -q -y install build-essential || exit $?

	tar -C /usr/local -xzf "${DOCKER_SRC}/go${ver}.linux-amd64.tar.gz" || exit $?
fi

true


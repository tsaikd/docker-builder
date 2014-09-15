#!/bin/bash

ver="x20.1"

if ! type liteide &>/dev/null ; then
	apt-get -q -y install libglib2.0-0 gdb

	tar -C /usr/local -xjf "${DOCKER_SRC}/liteide${ver}.linux-amd64.tar.bz2"

	ln -s "/usr/local/liteide/bin/liteide" "/usr/bin/liteide"
fi

true


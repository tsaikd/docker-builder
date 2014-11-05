#!/bin/bash

if ! type liteide &>/dev/null ; then
	apt-get -q -y install libglib2.0-0 gdb

	tar -C /usr/local -xjf "${DOCKER_SRC}/liteidex23.2.linux-64.tar.bz2"

	ln -s "/usr/local/liteide/bin/liteide" "/usr/local/bin/liteide"
fi

true


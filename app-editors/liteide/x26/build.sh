#!/bin/bash

if ! type liteide &>/dev/null ; then
	apt-get -q -y install libglib2.0-0 gdb

	mkdir -p "${LITEIDE_HOME}"
	tar -C "${LITEIDE_HOME}" --strip-components=1 -xf "${DOCKER_SRC}/liteide${LITEIDE_VERSION}.linux-64.tar.bz2"

	ln -s "${LITEIDE_HOME}/bin/liteide" "/usr/local/bin/liteide"
fi


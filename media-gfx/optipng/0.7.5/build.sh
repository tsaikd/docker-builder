#!/bin/bash

if ! type optipng &>/dev/null ; then
	apt-get install -qy zlib1g-dev
	mkdir -p /usr/local/src/optipng
	tar -C /usr/local/src/optipng --strip-components=1 -xf "${DOCKER_SRC}/optipng-${OPTIPNG_VERSION}.tar.gz"
	pushd /usr/local/src/optipng >/dev/null
	./configure
	make
	cp -a src/optipng/optipng /usr/local/bin/
	popd >/dev/null
	rm -rf /usr/local/src/optipng
	apt-get purge -qy zlib1g-dev
fi


#!/bin/bash

if ! type redis-server &>/dev/null ; then
	mkdir -p /usr/local/src/redis
	tar -C /usr/local/src/redis --strip-components=1 -xf "${DOCKER_SRC}/redis-${REDIS_VERSION}.tar.gz"
	gem install redis
	pushd /usr/local/src/redis >/dev/null
	make
	for i in redis-benchmark redis-check-aof redis-check-dump redis-cli redis-sentinel redis-server redis-trib.rb ; do
		cp -a "src/${i}" /usr/local/bin/
	done
	popd >/dev/null
fi


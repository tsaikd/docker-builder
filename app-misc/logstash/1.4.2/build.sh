#!/bin/bash

if ! type logstash &>/dev/null ; then
	mkdir -p /usr/local/logstash
	tar -C /usr/local/logstash --strip-components=1 -xf "${DOCKER_SRC}/logstash-${LOGSTASH_VER}.tar.gz"
	tar -C /usr/local/logstash --strip-components=1 -xf "${DOCKER_SRC}/logstash-contrib-${LOGSTASH_VER}.tar.gz"
fi


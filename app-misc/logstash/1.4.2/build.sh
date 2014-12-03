#!/bin/bash

if ! type logstash &>/dev/null ; then
	ver="1.4.2"
	tar -C /usr/local -xzf "${DOCKER_SRC}/logstash-${ver}.tar.gz"
	ln -s "/usr/local/logstash-${ver}/" "/usr/local/logstash"
fi


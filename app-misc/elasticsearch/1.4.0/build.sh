#!/bin/bash

if ! type elasticsearch &>/dev/null ; then
	ver="1.4.0"
	tar -C /usr/local -xzf "${DOCKER_SRC}/elasticsearch-${ver}.tar.gz"
	ln -s "/usr/local/elasticsearch-${ver}/" "/usr/local/elasticsearch"
	ln -s /usr/local/elasticsearch/bin/* /usr/local/bin/
fi


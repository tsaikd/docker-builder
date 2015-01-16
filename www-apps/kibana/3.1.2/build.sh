#!/bin/bash

if [ ! -d "/usr/local/kibana" ] ; then
	mkdir -p "/usr/local/kibana"
	tar -C "/usr/local/kibana" --strip-components=1 -xzf "${DOCKER_SRC}/kibana-${KIBANA_VER}.tar.gz"
fi


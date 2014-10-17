#!/bin/bash

ver="1.3.4"

tar -C /usr/local -xzf "${DOCKER_SRC}/elasticsearch-${ver}.tar.gz"
ln -s "/usr/local/elasticsearch-${ver}/" "/usr/local/elasticsearch"


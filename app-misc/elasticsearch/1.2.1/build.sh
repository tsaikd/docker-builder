#!/bin/bash

ver="1.2.1"

pushd /usr/local &>/dev/null

tar -xzf "${DOCKER_SRC}/elasticsearch-${ver}.tar.gz"

popd &>/dev/null


#!/bin/bash

ver="1.2.1"

pushd /usr/local &>/dev/null || exit $?

tar -xzf "${DOCKER_SRC}/elasticsearch-${ver}.tar.gz" || exit $?

popd &>/dev/null || exit $?


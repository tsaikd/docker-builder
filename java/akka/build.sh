#!/bin/bash

# apt
apt-get -q -y install p7zip-full || exit $?

pushd /usr/local &>/dev/null || exit $?
7z x "${DOCKER_SRC}/typesafe-activator-1.2.1.zip" || exit $?
popd &>/dev/null || exit $?


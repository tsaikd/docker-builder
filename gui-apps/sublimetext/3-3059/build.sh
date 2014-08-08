#!/bin/bash

# apt
apt-get -q -y install libglib2.0-0 libcairo2 libpango1.0-0 libgtk2.0-0 || exit $?

pushd "${DOCKER_SRC}" &>/dev/null
dpkg -i sublime-text*.deb || exit $?
popd &>/dev/null

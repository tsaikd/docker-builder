#!/bin/bash

if ! type subl &>/dev/null ; then
	apt-get -q -y install libglib2.0-0 libcairo2 libpango1.0-0 libgtk2.0-0

	pushd "${DOCKER_SRC}" &>/dev/null
	dpkg -i sublime-text*.deb
	popd &>/dev/null
fi

true


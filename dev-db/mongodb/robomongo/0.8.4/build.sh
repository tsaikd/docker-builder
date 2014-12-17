#!/bin/bash

if ! type robomongo &>/dev/null ; then
	apt-get -q -y install libqt5gui5
	dpkg -i "${DOCKER_SRC}/robomongo-${ROBOMONGO_VERSION}-x86_64.deb"
fi


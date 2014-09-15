#!/bin/bash

if ! type eclipse &>/dev/null ; then
	pushd /usr/local &>/dev/null

	tar xf "${DOCKER_SRC}/eclipse-jee-luna-R-linux-gtk-x86_64.tar.gz"

	ln -s /usr/local/eclipse/eclipse /usr/bin/eclipse

	popd &>/dev/null
fi

true


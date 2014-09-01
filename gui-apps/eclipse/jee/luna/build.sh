#!/bin/bash

if ! type eclipse &>/dev/null ; then
	pushd /usr/local &>/dev/null || exit $?

	tar xf "${DOCKER_SRC}/eclipse-jee-luna-R-linux-gtk-x86_64.tar.gz" || exit $?

	ln -s /usr/local/eclipse/eclipse /usr/bin/eclipse || exit $?

	popd &>/dev/null || exit $?
fi

true


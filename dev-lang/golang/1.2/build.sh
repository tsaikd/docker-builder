#!/bin/bash

if ! type go &>/dev/null ; then
	# apt
	apt-get -q -y install build-essential

	# go 1.2 tarball https://go.googlecode.com/files/go1.2.linux-amd64.tar.gz
	tar -C /usr/local -xzf $DOCKER_SRC/go1.2.linux-amd64.tar.gz
fi

true


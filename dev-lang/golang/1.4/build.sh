#!/bin/bash

if ! type go &>/dev/null ; then
	apt-get -q -y install build-essential

	tar -C /usr/local -xzf "${DOCKER_SRC}/go${GO_VERSION}.linux-amd64.tar.gz"

	mkdir -p "${GOPATH:-/opt/go}"
fi


#!/bin/bash

ver="1.3.3"

if ! type go &>/dev/null ; then
	apt-get -q -y install build-essential

	tar -C /usr/local -xzf "${DOCKER_SRC}/go${ver}.linux-amd64.tar.gz"

	ln -s /usr/local/go/bin/* /usr/local/bin/

	# set GOPATH
	export GOPATH="${GOPATH:-/opt/go}"
	echo 'export GOPATH="${GOPATH:-/opt/go}"' >> /etc/profile.d/01-env.sh
	mkdir -p "${GOPATH}"
fi


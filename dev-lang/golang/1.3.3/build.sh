#!/bin/bash

ver="1.3.3"

if ! type go &>/dev/null ; then
	apt-get -q -y install build-essential

	tar -C /usr/local -xzf "${DOCKER_SRC}/go${ver}.linux-amd64.tar.gz"

	# set GOPATH
	export GOPATH="${GOPATH:-/opt/go}"
	export PATH="${GOPATH}/bin:/usr/local/go/bin:${PATH}"
	echo 'export GOPATH="${GOPATH:-/opt/go}"' >> /etc/profile.d/01-env.sh
	echo 'export PATH="${GOPATH}/bin:/usr/local/go/bin:${PATH}"' >> /etc/profile.d/01-env.sh
	mkdir -p "${GOPATH}"
fi

true


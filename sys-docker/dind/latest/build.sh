#!/bin/bash

if ! type apparmor_parser &>/dev/null ; then
	apt-get -q -y install apparmor
fi

if ! type docker &>/dev/null ; then
	cat > /etc/apt/sources.list.d/docker.list <<EOF
deb http://get.docker.io/ubuntu docker main
EOF

	apt-get -q update

	apt-get -q -y --force-yes install lxc-docker
fi

if ! type wrapdocker &>/dev/null ; then
	chmod +x "${DOCKER_SRC}/wrapdocker"
	cp -a "${DOCKER_SRC}/wrapdocker" "/usr/bin/wrapdocker"
fi


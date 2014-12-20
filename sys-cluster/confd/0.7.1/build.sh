#!/bin/bash

if ! type confd &>/dev/null ; then
	cp -a "${DOCKER_SRC}/confd-${CONFD_VERSION}-linux-amd64" /usr/local/bin/confd
	chmod +x /usr/local/bin/confd
fi


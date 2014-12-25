#!/bin/bash

if ! type skydns &>/dev/null ; then
	cp -a "${DOCKER_SRC}/skydns-linux-amd64" /usr/local/bin/skydns
	chmod +x /usr/local/bin/skydns
fi


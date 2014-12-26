#!/bin/bash

if ! type registrator &>/dev/null ; then
	cp -a "${DOCKER_SRC}/registrator-linux-amd64" /usr/local/bin/registrator
	chmod +x /usr/local/bin/registrator
fi


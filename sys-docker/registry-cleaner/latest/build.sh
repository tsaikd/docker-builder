#!/bin/bash

if ! type jq &>/dev/null ; then
	apt-get -q -y install jq
fi

if ! type remove-orphan-images.sh &>/dev/null ; then
	chmod +x "${DOCKER_SRC}/remove-orphan-images.sh"
	cp -a "${DOCKER_SRC}/remove-orphan-images.sh" "/usr/local/bin/"
fi


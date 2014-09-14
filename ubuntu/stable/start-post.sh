#!/bin/bash

if [ -d "${DOCKER_SRC}/custom" ] ; then
	cp -aL "${DOCKER_SRC}/custom/"* /
fi

if [ -f "/start.sh" ] ; then
	source "/start.sh"
fi

if [ -t 0 ] ; then
	bash
fi


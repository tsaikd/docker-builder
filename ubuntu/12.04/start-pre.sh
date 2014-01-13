#!/bin/bash

if [ -f /config.sh ] ; then
	source /config.sh
fi

if [ -d "$DOCKER_SRC/custom" ] ; then
	cp -aL "$DOCKER_SRC/custom/"* /
fi

true


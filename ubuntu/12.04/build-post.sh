#!/bin/bash

if [ -d "$DOCKER_SRC/root" ] ; then
	cp -aL "$DOCKER_SRC/root/"* /
fi

true


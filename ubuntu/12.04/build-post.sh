#!/bin/bash

if [ -d "$DOCKER_SRC/root" ] ; then
	cp -a "$DOCKER_SRC/root/"* /
fi

true


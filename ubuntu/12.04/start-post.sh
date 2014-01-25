#!/bin/bash

if [ -d "$DOCKER_SRC/custom" ] ; then
	cp -aL "$DOCKER_SRC/custom/"* /
fi

bash

true


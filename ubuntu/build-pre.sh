#!/bin/bash

source "$DOCKER_SRC/config.sh.sample"

if [ -f "$DOCKER_SRC/config.sh" ] ; then
	source "$DOCKER_SRC/config.sh"
fi

true


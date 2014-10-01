#!/bin/bash

if [ -d "${DOCKER_SRC}/root" ] ; then
	cp -aL "${DOCKER_SRC}/root/"* /
fi

export DOCKER_BUILDING="1"

if [ -f "${DOCKER_SRC}/start-all.sh" ] ; then
	bash "${DOCKER_SRC}/start-all.sh"
fi

if [ -f "${DOCKER_SRC}/test-all.sh" ] ; then
	bash "${DOCKER_SRC}/test-all.sh"
fi

unset DOCKER_BUILDING

true


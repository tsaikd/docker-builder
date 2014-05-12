#!/bin/bash

if [ -d "$DOCKER_SRC/root" ] ; then
	cp -aL "$DOCKER_SRC/root/"* /
fi

if [ -f "$DOCKER_SRC/start-all.sh" ] ; then
	bash "$DOCKER_SRC/start-all.sh" || exit $?
fi

if [ -f "$DOCKER_SRC/test-all.sh" ] ; then
	bash "$DOCKER_SRC/test-all.sh" || exit $?
fi

true


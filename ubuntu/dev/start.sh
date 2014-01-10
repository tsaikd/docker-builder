#!/bin/bash

source "$DOCKER_SRC/config.sh.sample"

if [ -f "$DOCKER_SRC/config.sh" ] ; then
	source "$DOCKER_SRC/config.sh"
fi

if [ -f "$DOCKER_SRC/start-pre.sh" ] ; then
	source "$DOCKER_SRC/start-pre.sh"
fi

/usr/sbin/sshd

if [ -f "$DOCKER_SRC/start-post.sh" ] ; then
	source "$DOCKER_SRC/start-post.sh"
fi

bash


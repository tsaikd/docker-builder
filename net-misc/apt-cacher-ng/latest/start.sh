#!/bin/bash

if [ -d "/var/cache/apt-cacher-ng" ] ; then
	chown 103:106 -R "/var/cache/apt-cacher-ng" || exit $?
fi

service apt-cacher-ng restart


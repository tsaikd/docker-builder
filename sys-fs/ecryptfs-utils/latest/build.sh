#!/bin/bash

if ! type mount.ecryptfs &>/dev/null ; then
	apt-get -q -y install ecryptfs-utils
fi


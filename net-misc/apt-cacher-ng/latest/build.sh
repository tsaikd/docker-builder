#!/bin/bash

if ! type apt-cacher-ng &>/dev/null ; then
	apt-get -q -y install apt-cacher-ng || exit $?
fi

true


#!/bin/bash

if ! type curl &>/dev/null ; then
	apt-get -q -y install curl || exit $?
fi

true


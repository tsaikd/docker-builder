#!/bin/bash

if ! type apache2 &>/dev/null ; then
	apt-get -q -y install apache2 || exit $?
fi

true


#!/bin/bash

if ! type dig &>/dev/null ; then
	apt-get -q -y install dnsutils || exit $?
fi

true


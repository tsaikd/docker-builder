#!/bin/bash

if ! type make &>/dev/null ; then
	apt-get -q -y install build-essential
fi


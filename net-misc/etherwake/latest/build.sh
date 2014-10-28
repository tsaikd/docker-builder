#!/bin/bash

if ! type etherwake &>/dev/null ; then
	apt-get -q -y install etherwake
fi


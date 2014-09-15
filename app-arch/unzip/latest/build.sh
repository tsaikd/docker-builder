#!/bin/bash

if ! type unzip &>/dev/null ; then
	apt-get -q -y install unzip
fi

true

#!/bin/bash

if ! type 7z &>/dev/null ; then
	apt-get -q -y install p7zip-full
fi

true

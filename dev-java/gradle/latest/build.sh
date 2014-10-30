#!/bin/bash

if ! type gradle &>/dev/null ; then
	apt-get -q -y install gradle
fi


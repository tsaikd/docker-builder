#!/bin/bash

if ! type apache2 &>/dev/null ; then
	apt-get -q -y install apache2
fi

true


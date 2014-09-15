#!/bin/bash

if ! type nginx &>/dev/null ; then
	apt-get -q -y --force-yes install nginx
fi

true


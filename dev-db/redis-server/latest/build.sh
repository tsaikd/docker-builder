#!/bin/bash

if ! type redis-server &>/dev/null ; then
	apt-get -q -y install redis-server
fi


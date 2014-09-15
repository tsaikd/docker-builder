#!/bin/bash

if ! type php5 &>/dev/null ; then
	apt-get -q -y install libapache2-mod-php5
fi

true


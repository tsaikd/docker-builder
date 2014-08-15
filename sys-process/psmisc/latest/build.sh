#!/bin/bash

if ! type killall &>/dev/null ; then
	apt-get -q -y install psmisc || exit $?
fi

true


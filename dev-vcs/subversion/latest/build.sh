#!/bin/bash

if ! type svn &>/dev/null ; then
	apt-get -q -y install subversion
fi

true


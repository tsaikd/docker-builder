#!/bin/bash

if ! type hg &>/dev/null ; then
	apt-get -q -y install mercurial
fi

true


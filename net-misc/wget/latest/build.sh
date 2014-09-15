#!/bin/bash

if ! type wget &>/dev/null ; then
	apt-get -q -y install wget
fi

true


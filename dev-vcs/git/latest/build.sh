#!/bin/bash

if ! type git &>/dev/null ; then
	apt-get -q -y install git || exit $?
fi

true


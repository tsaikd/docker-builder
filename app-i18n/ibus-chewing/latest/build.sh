#!/bin/bash

if ! type ibus &>/dev/null ; then
	apt-get -q -y install ibus-chewing
fi


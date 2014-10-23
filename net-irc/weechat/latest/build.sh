#!/bin/bash

if ! type weechat &>/dev/null ; then
	apt-get -q -y install weechat
fi


#!/bin/bash

if ! type rtorrent &>/dev/null ; then
	apt-get -q -y install rtorrent
fi


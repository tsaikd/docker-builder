#!/bin/bash

if ! type smbd &>/dev/null ; then
	apt-get -q -y install samba
fi

true


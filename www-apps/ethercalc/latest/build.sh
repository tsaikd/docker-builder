#!/bin/bash

if ! type python &>/dev/null ; then
	apt-get -qy install python
fi

if ! type ethercalc &>/dev/null ; then
	npm install -g ethercalc
fi


#!/bin/bash

if ! type godep &>/dev/null ; then
	go get -u -v github.com/tools/godep
fi

true


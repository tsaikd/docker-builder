#!/bin/bash

if ! type godep &>/dev/null ; then
	go get -u -v github.com/tools/godep
	ln -s "${GOPATH}/bin/godep" "/usr/local/bin/godep"
fi


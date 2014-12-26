#!/bin/bash

if ! type gor &>/dev/null ; then
	go get -u -v github.com/wendal/gor

	go install github.com/wendal/gor/gor
fi


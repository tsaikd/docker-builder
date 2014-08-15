#!/bin/bash

if ! type gor &>/dev/null ; then
	go get -u github.com/wendal/gor || exit $?

	go install github.com/wendal/gor/gor || exit $?
fi

true


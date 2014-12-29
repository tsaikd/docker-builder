#!/bin/bash

if ! type sysd &>/dev/null ; then
	mkdir -p /opt/go/src/github.com/hacking-thursday
	pushd /opt/go/src/github.com/hacking-thursday >/dev/null
	git clone https://github.com/hacking-thursday/sysd
	cd sysd
	git checkout -b devel -t origin/devel
	git reset --hard origin/devel
	cd sysd
	go get -t -u -v
	go test
	go build
	ln -s "${PWD}/sysd" "/usr/local/bin/sysd"
	popd >/dev/null
fi


#!/bin/bash

if ! type mitmproxy &>/dev/null ; then
	apt-get -qy --force-yes install build-essential python-dev libffi-dev libssl-dev libxml2-dev libxslt1-dev python-pip
	pip install mitmproxy
fi


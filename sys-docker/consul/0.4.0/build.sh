#!/bin/bash

if ! type consul &>/dev/null ; then
	mkdir -p /var/lib/consul
	pushd /var/lib/consul >/dev/null

	7z x "${DOCKER_SRC}/*_linux_amd64.zip"
	chmod +x "${DOCKER_SRC}/consul-wrap"
	cp -a "${DOCKER_SRC}/consul-wrap" "/usr/bin/consul"

	7z x "${DOCKER_SRC}/*_web_ui.zip"
	mv dist web-ui

	mkdir -p config data
	cp -a "${DOCKER_SRC}/consul.json" "config/consul.json"

	popd >/dev/null
fi


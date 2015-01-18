#!/bin/bash

if ! type cf-dns-ip &>/dev/null ; then
	cp -a "${DOCKER_SRC}/cf-dns-ip" /usr/local/bin/cf-dns-ip
	cp -a "${DOCKER_SRC}/cf-dns-ip.py" /usr/local/bin/cf-dns-ip.py
	cp -a "${DOCKER_SRC}/cloudflare/" /usr/local/bin/
	chmod +x /usr/local/bin/cf-dns-ip
	chmod +x /usr/local/bin/cf-dns-ip.py
fi


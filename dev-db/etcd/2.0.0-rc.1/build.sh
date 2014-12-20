#!/bin/bash

if ! type etcd &>/dev/null ; then
	mkdir -p /usr/local/etcd

	tar -C /usr/local/etcd --strip-components=1 -xf "${DOCKER_SRC}/etcd-${ETCD_VER}-linux-amd64.tar.gz"
fi


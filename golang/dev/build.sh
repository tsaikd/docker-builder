#!/bin/bash

# apt
apt-get update || exit $?
apt-get install -y build-essential mercurial git subversion wget || exit $?

# go 1.2 tarball https://go.googlecode.com/files/go1.2.linux-amd64.tar.gz
tar -C /usr/local -xzf /opt/docker/tsaikd/golang/go1.2.linux-amd64.tar.gz || exit $?


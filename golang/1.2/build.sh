#!/bin/bash

# apt
apt-get -q update || exit $?
apt-get -q -y install build-essential mercurial git subversion wget || exit $?
apt-get -q clean || exit $?

# go 1.2 tarball https://go.googlecode.com/files/go1.2.linux-amd64.tar.gz
tar -C /usr/local -xzf $DOCKER_SRC/go1.2.linux-amd64.tar.gz || exit $?


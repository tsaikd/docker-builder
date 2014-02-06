#!/bin/bash

apt-get -q update || exit $?
apt-get -q -y install apt-cacher-ng || exit $?
apt-get -q clean || exit $?


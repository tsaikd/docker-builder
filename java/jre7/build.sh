#!/bin/bash

apt-get -q update || exit $?
apt-get -q -y install openjdk-7-jre-headless || exit $?
apt-get -q clean || exit $?


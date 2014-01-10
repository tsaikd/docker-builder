#!/bin/bash

apt-get -q update || exit $?
apt-get -q -y install openjdk-6-jdk || exit $?
apt-get -q clean || exit $?


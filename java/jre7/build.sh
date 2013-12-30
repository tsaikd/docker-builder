#!/bin/bash

apt-get -qq update || exit $?
apt-get -qq -y install openjdk-7-jre-headless || exit $?
apt-get -qq clean || exit $?


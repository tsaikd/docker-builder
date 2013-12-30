#!/bin/bash

apt-get -qq update || exit $?
apt-get -qq -y install tomcat7 || exit $?
apt-get -qq clean || exit $?


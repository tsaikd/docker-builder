#!/bin/bash

apt-get -q update || exit $?
apt-get -q -y install tomcat7 tomcat7-admin || exit $?
apt-get -q clean || exit $?

rm -f /var/log/tomcat7/*


#!/bin/bash

ver="7.0.50"

tar -C /usr/local -xzf $DOCKER_SRC/apache-tomcat-$ver.tar.gz || exit $?

mv /usr/local/apache-tomcat-$ver/conf /etc/tomcat7 || exit $?
mv /usr/local/apache-tomcat-$ver/logs /var/log/tomcat7 || exit $?
mv /usr/local/apache-tomcat-$ver/work /var/cache/tomcat7 || exit $?
mv /usr/local/apache-tomcat-$ver /var/lib/tomcat7 || exit $?

cd /var/lib/tomcat7 || exit $?

ln -s /etc/tomcat7 conf || exit $?
ln -s ../../log/tomcat7 logs || exit $?
ln -s ../../cache/tomcat7 work || exit $?


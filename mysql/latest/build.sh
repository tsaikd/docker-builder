#!/bin/bash

dpkg-divert --local --rename --add /sbin/initctl || exit $?

debconf-set-selections <<< "mysql-server mysql-server/root_password password ${MYSQL_ROOT_PASSWD}"
debconf-set-selections <<< "mysql-server mysql-server/root_password_again password ${MYSQL_ROOT_PASSWD}"

apt-get -q update || exit $?
apt-get -q -y --force-yes install mysql-server|| exit $?
apt-get -q clean || exit $?

sed -i '/^bind-address/{s/127.0.0.1/0.0.0.0/}' /etc/mysql/my.cnf


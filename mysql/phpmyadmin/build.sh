#!/bin/bash

debconf-set-selections <<< "phpmyadmin phpmyadmin/dbconfig-install boolean true"
debconf-set-selections <<< "phpmyadmin phpmyadmin/reconfigure-webserver multiselect apache2"
debconf-set-selections <<< "phpmyadmin phpmyadmin/mysql/app-pass password ${MYSQL_ROOT_PASSWD}"
debconf-set-selections <<< "phpmyadmin phpmyadmin/mysql/admin-pass password ${MYSQL_ROOT_PASSWD}"
debconf-set-selections <<< "phpmyadmin phpmyadmin/app-password-confirm password ${MYSQL_ROOT_PASSWD}"

apt-get -q update || exit $?
apt-get -q -y install phpmyadmin || exit $?
apt-get -q clean || exit $?


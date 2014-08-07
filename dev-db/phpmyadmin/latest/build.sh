#!/bin/bash

debconf-set-selections <<< "phpmyadmin phpmyadmin/dbconfig-install boolean true"
debconf-set-selections <<< "phpmyadmin phpmyadmin/reconfigure-webserver multiselect apache2"
debconf-set-selections <<< "phpmyadmin phpmyadmin/mysql/app-pass password ${MYSQL_ROOT_PASSWD}"
debconf-set-selections <<< "phpmyadmin phpmyadmin/mysql/admin-pass password ${MYSQL_ROOT_PASSWD}"
debconf-set-selections <<< "phpmyadmin phpmyadmin/app-password-confirm password ${MYSQL_ROOT_PASSWD}"

apt-get -q -y install phpmyadmin || exit $?

confpath="/etc/apache2/sites-enabled/000-default"
line="$(sed -n "/Directory \/var\/www\//=" "${confpath}")"
line="$(sed -n "${line},+5{/Allow/=}" "${confpath}")"
sed -i "${line}{s/None/All/}" "${confpath}"

echo "Redirect 301 / /phpmyadmin/" >> "/var/www/.htaccess"


#!/bin/bash

apt-get -q update || exit $?
apt-get -q -y install apache2 libapache2-mod-php5 || exit $?
apt-get -q clean || exit $?


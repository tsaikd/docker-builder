#!/bin/bash

apt-get -qy install php5-fpm

tar -C /var/www/html -xf "${DOCKER_SRC}/rutorrent-${RUTORRENT_VERSION}.tar.gz"


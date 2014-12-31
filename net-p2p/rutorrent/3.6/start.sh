#!/bin/bash

sudo service php5-fpm restart

if [ "${RTORRENT_PORT_5000_TCP_ADDR}" ] ; then
	ip="${RTORRENT_PORT_5000_TCP_ADDR}"
	port="5000"
else
	ip="${RTORRENT_IP}"
	port="${RTORRENT_PORT}"
fi

if [ "${ip}" ] && [ "${port}" ] ; then
	sed -i "s/scgi_pass .*\$/scgi_pass ${ip}:${port};/g" /etc/nginx/sites-enabled/default
	sed -i "s/scgi_host.*$/scgi_host = \"${ip}\";/g" /var/www/html/rutorrent/conf/config.php
	sed -i "s/scgi_port.*$/scgi_port = ${port};/g" /var/www/html/rutorrent/conf/config.php
	sudo service nginx restart
fi


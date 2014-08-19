#!/bin/bash

if [ -d "/var/cache/apt-cacher-ng" ] ; then
	chown 103:106 -R "/var/cache/apt-cacher-ng" || exit $?
fi

if ! type apt-cacher-ng &>/dev/null ; then
	apt-get -q -y install apt-cacher-ng || exit $?
	if [ "${http_proxy}" ] ; then
		echo "Proxy: ${http_proxy}" >> /etc/apt-cacher-ng/acng.conf
	elif [ "${https_proxy}" ] ; then
		echo "Proxy: ${https_proxy}" >> /etc/apt-cacher-ng/acng.conf
	fi
fi

true


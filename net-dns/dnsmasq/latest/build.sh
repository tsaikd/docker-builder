#!/bin/bash

if ! type dnsmasq &>/dev/null ; then
	apt-get -q -y install dnsmasq

	# see https://github.com/docker/docker/issues/1951#issuecomment-36303920
	echo "user=root" >> /etc/dnsmasq.conf
fi

true


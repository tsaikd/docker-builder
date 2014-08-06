#!/bin/bash

redist=`sed -n 's/DISTRIB_CODENAME=\(.*\)$/\1/p' /etc/lsb-release`

if [ "$redist" != "precise" ] ; then
	sed -i "s/precise/$redist/g" /etc/apt/sources.list.d/nginx.list
fi

apt-get -q -y --force-yes install nginx || exit $?


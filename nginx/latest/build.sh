#!/bin/bash

redist=`sed -n 's/DISTRIB_CODENAME=\(.*\)$/\1/p' /etc/lsb-release`

cp -a "$DOCKER_SRC/nginx.list" /etc/apt/sources.list.d/ || exit $?

if [ "$redist" != "precise" ] ; then
	sed -i "s/precise/$redist/g" /etc/apt/sources.list.d/nginx.list
fi

apt-get -qq update || exit $?
apt-get -qq -y --force-yes install nginx || exit $?
apt-get -qq clean || exit $?

echo "daemon off;" >> /etc/nginx/nginx.conf


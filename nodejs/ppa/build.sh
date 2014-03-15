#!/bin/bash

redist=`sed -n 's/DISTRIB_CODENAME=\(.*\)$/\1/p' /etc/lsb-release`

if [ "$redist" != "precise" ] ; then
	sed -i "s/precise/$redist/g" /etc/apt/sources.list.d/nodejs.list
fi

apt-get -q update || exit $?
apt-get -q -y --force-yes install nodejs || exit $?
apt-get -q clean || exit $?


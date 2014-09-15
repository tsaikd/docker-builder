#!/bin/bash

if ! type nginx &>/dev/null ; then
	redist=`sed -n 's/DISTRIB_CODENAME=\(.*\)$/\1/p' /etc/lsb-release`

	cat > /etc/apt/sources.list.d/nginx.list <<EOF
deb http://ppa.launchpad.net/nginx/stable/ubuntu ${redist} main
deb-src http://ppa.launchpad.net/nginx/stable/ubuntu ${redist} main
EOF

	apt-get -q update

	apt-get -q -y --force-yes install nginx
fi


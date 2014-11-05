#!/bin/bash

if ! type sysd &>/dev/null ; then
	redist=`sed -n 's/DISTRIB_CODENAME=\(.*\)$/\1/p' /etc/lsb-release`

	cat > /etc/apt/sources.list.d/sysd.list <<EOF
deb http://ppa.launchpad.net/matlinuxer2/sysd/ubuntu ${redist} main
deb-src http://ppa.launchpad.net/matlinuxer2/sysd/ubuntu ${redist} main
EOF

	apt-get -q -y update

	apt-get -q -y --force-yes install sysd
fi


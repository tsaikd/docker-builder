#!/bin/bash

if ! type virtualbox &>/dev/null ; then
	redist=`sed -n 's/DISTRIB_CODENAME=\(.*\)$/\1/p' /etc/lsb-release`

	cat > /etc/apt/sources.list.d/vbox.list <<EOF
deb http://download.virtualbox.org/virtualbox/debian ${redist} contrib
EOF

	apt-get -q update

	apt-get -q -y --force-yes install linux-headers-$(uname -r) virtualbox-4.3

	sed -in 's|\(MINOR=.*vboxdrv\)$\?\(.* /proc/misc.\)$|\1$\2|' /etc/init.d/vboxdrv
fi

true

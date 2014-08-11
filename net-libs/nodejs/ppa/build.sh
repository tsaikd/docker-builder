#!/bin/bash

redist=`sed -n 's/DISTRIB_CODENAME=\(.*\)$/\1/p' /etc/lsb-release`

cat > /etc/apt/sources.list.d/nodejs.list <<EOF
deb http://ppa.launchpad.net/chris-lea/node.js/ubuntu ${redist} main
deb-src http://ppa.launchpad.net/chris-lea/node.js/ubuntu ${redist} main
EOF

apt-get -q -y --force-yes install nodejs npm || exit $?

ln -s /usr/bin/nodejs /usr/local/bin/node || exit $?


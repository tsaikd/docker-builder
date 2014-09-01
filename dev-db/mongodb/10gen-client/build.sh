#!/bin/bash

if ! type mongo &>/dev/null ; then
	apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10 || exit $?

	cat > /etc/apt/sources.list.d/mongodb.list <<-EOF
deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen
	EOF

	apt-get -q -y update || exit $?

	apt-get -q -y install mongodb-org-shell mongodb-org-mongos mongodb-org-tools || exit $?
fi

true


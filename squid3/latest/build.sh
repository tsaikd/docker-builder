#!/bin/bash

apt-get -q update || exit $?
apt-get -qy --force-yes install squid3 || exit $?
apt-get -q clean || exit $?

sed -i "s/^#acl localnet/acl localnet/" /etc/squid3/squid.conf
sed -i "s/^#http_access allow localnet/http_access allow localnet/" /etc/squid3/squid.conf


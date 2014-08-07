#!/bin/bash

chown proxy:proxy /var/spool/squid3
if [ -z "$(ls /var/spool/squid3)" ] ; then
	squid3 -z
fi

squid3

true


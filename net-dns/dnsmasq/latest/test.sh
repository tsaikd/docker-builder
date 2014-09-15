#!/bin/bash

maxtime="$(( $(date +%s) + 60 ))"

for i in dnsmasq ; do
	echo "Testing command ${i} is valid ..."
	type "${i}" &>/dev/null
done

for i in 53 ; do
	echo "Testing udp port ${i} is opened ..."
	while [ -z "$(netstat -uln | grep "${i} ")" ] ; do
		[ "$(date +%s)" -gt "${maxtime}" ] && exit 1
		sleep 1
	done
done

true


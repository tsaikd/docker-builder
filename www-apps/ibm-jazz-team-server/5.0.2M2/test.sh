#!/bin/bash

maxtime="$(( $(date +%s) + 180 ))"

for i in 9443 ; do
	echo "Testing tcp port ${i} is opened ..."
	while [ -z "$(netstat -tln | grep "${i} ")" ] ; do
		[ "$(date +%s)" -gt "${maxtime}" ] && exit 1
		sleep 1
	done
done

for i in https://localhost:9443/jts/setup ; do
	echo "Testing http request ${i} success ..."
	while [ -z "$(curl -sIk "${i}" | sed -n "1{/200/p}")" ] ; do
		[ "$(date +%s)" -gt "${maxtime}" ] && exit 1
		sleep 1
	done
done

true


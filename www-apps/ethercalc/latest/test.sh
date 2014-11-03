#!/bin/bash

maxtime="$(( $(date +%s) + 300 ))"

for i in 8000 ; do
	echo "Testing tcp port ${i} is opened ..."
	while [ -z "$(netstat -tln | grep "${i} ")" ] ; do
		[ "$(date +%s)" -gt "${maxtime}" ] && exit 1
		sleep 1
	done
done

for i in http://localhost:8000/ ; do
	echo "Testing http request ${i} ..."
	while [ -z "$(http_proxy="" curl -sIk -m 9 "${i}" | sed -n "1{/200/p}")" ] ; do
		[ "$(date +%s)" -gt "${maxtime}" ] && exit 1
		sleep 1
	done
done


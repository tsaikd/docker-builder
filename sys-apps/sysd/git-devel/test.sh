#!/bin/bash

maxtime="$(( $(date +%s) + 60 ))"

for i in sysd ; do
	echo "Testing command ${i} is valid ..."
	type "${i}" &>/dev/null
done


for i in 8080 ; do
	echo "Testing tcp port ${i} is opened ..."
	while [ -z "$(netstat -tln | grep "${i} ")" ] ; do
		[ "$(date +%s)" -gt "${maxtime}" ] && exit 1
		sleep 1
	done
done

for i in http://localhost:8080/apilist ; do
	echo "Testing http request ${i} ..."
	while [ -z "$(http_proxy="" curl -sIk -m 9 -XGET "${i}" | sed -n "1{/200/p}")" ] ; do
		[ "$(date +%s)" -gt "${maxtime}" ] && exit 1
		sleep 1
	done
done


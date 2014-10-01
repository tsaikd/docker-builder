#!/bin/bash

maxtime="$(( $(date +%s) + 60 ))"

for i in consul ; do
	echo "Testing command ${i} is valid ..."
	type "${i}" &>/dev/null || exit 1
done

for i in 53 8300 8301 8302 8400 8500 ; do
	echo "Testing tcp port ${i} is opened ..."
	while [ -z "$(netstat -tln | grep "${i} ")" ] ; do
		[ "$(date +%s)" -gt "${maxtime}" ] && exit 1
		sleep 1
	done
done

for i in 53 8301 8302 ; do
	echo "Testing udp port ${i} is opened ..."
	while [ -z "$(netstat -uln | grep "${i} ")" ] ; do
		[ "$(date +%s)" -gt "${maxtime}" ] && exit 1
		sleep 1
	done
done


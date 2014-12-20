#!/bin/bash

maxtime="$(( $(date +%s) + 60 ))"

for i in etcd ; do
	echo "Testing command ${i} is valid ..."
	type "${i}" &>/dev/null || exit 1
done

for i in 4001 7001 2379 2380 ; do
	echo "Testing tcp port ${i} is opened ..."
	while [ -z "$(netstat -tln | grep "${i} ")" ] ; do
		[ "$(date +%s)" -gt "${maxtime}" ] && exit 1
		sleep 1
	done
done

# clean test file
pkill etcd || true
rm -rf default.etcd || true


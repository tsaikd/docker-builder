#!/bin/bash

maxtime="$(( $(date +%s) + 60 ))"

for i in apt-cacher-ng ; do
	echo "Testing command ${i} is valid ..."
	type "${i}" &>/dev/null || exit 1
done

for i in 3142 ; do
	echo "Testing tcp port ${i} is opened ..."
	while [ -z "$(netstat -tln | grep "${i} ")" ] ; do
		[ "$(date +%s)" -gt "${maxtime}" ] && exit 1
		sleep 1
	done
done

true


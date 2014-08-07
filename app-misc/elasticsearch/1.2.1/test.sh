#!/bin/bash

maxtime="$(( $(date +%s) + 60 ))"

for i in 9200 9300 ; do
	echo "Testing port ${i} is opened ..."
	while [ -z "$(netstat -tln | grep "${i} ")" ] ; do
		[ "$(date +%s)" -gt "${maxtime}" ] && exit 1
		sleep 1
	done
done

true


#!/bin/bash

maxtime="$(( $(date +%s) + 60 ))"

for i in sysd ; do
	echo "Testing command ${i} is valid ..."
	type "${i}" &>/dev/null
done


for i in 8 ; do
	echo "Testing tcp port ${i} is opened ..."
	while [ -z "$(netstat -tln | grep "${i} ")" ] ; do
		[ "$(date +%s)" -gt "${maxtime}" ] && exit 1
		sleep 1
	done
done

echo "Testing url http://localhost:8/apilist is valid ..."
while ((1)) ; do
	[ "$(date +%s)" -gt "${maxtime}" ] && exit 1
	if exec 5<> /dev/tcp/localhost/8 ; then
		echo -e "GET /apilist HTTP/1.0\r\nHost: localhost\r\n\r\n" >&5
		[ "$(cat <&5 | grep "HTTP/1.0 200 OK")" ] && break
	fi
	sleep 1
done


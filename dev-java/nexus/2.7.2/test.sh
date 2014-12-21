#!/bin/bash

maxtime="$(( $(date +%s) + 180 ))"

echo "Testing url http://localhost:8080/nexus/ is valid ..."
while ((1)) ; do
	[ "$(date +%s)" -gt "${maxtime}" ] && exit 1
	if exec 5<> /dev/tcp/localhost/8080 ; then
		echo -e "GET /nexus/index.html HTTP/1.0\r\nHost: localhost\r\n\r\n" >&5
		[ "$(cat <&5 | grep "HTTP/1.1 200 OK")" ] && break
	fi
	sleep 1
done


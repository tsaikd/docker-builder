#!/bin/bash

maxtime="$(( $(date +%s) + 180 ))"

echo "Testing url http://localhost:8080/nexus-${NEXUS_VERSION}/ is valid ..."
while [ "$(date +%s)" -lt "${maxtime}" ] ; do
	if exec 5<> /dev/tcp/localhost/8080 ; then
		echo -e "GET /nexus-${NEXUS_VERSION}/index.html HTTP/1.0\r\nHost: localhost\r\n\r\n" >&5
		[ "$(cat <&5 | grep "HTTP/1.1 200 OK")" ] && break
	fi
	sleep 1
done


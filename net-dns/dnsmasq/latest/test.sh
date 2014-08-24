#!/bin/bash

for i in dnsmasq ; do
	echo "Testing command ${i} is valid ..."
	type "${i}" &>/dev/null || exit 1
done

for i in 53 ; do
	echo "Testing port ${i} is opened ..."
	[ -z "$(netstat -uln | grep "${i} ")" ] && exit 1
done

true


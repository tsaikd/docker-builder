#!/bin/bash

for i in apt-cacher-ng ; do
	echo "Testing command ${i} is valid ..."
	type "${i}" &>/dev/null || exit 1
done

for i in 3142 ; do
	echo "Testing port ${i} is opened ..."
	[ -z "$(netstat -tln | grep "${i} ")" ] && exit 1
done

true


#!/bin/bash

for i in apache2 ; do
	echo "Testing command ${i} is valid ..."
	type "${i}" &>/dev/null || exit 1
done

for i in 80 ; do
	echo "Testing port ${i} is opened ..."
	[ -z "$(netstat -tln | grep "${i} ")" ] && exit 1
done

true


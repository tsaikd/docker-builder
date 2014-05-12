#!/bin/bash

for i in vim wget killall git sshd ; do
	echo "Testing command ${i} is valid ..."
	type "${i}" &>/dev/null || exit 1
done

for i in 22 ; do
	echo "Testing port ${i} is opened ..."
	[ -z "$(netstat -tln | grep "${i} ")" ] && exit 1
done

true


#!/bin/bash

for i in 3142 ; do
	echo "Testing port ${i} is opened ..."
	[ -z "$(netstat -tln | grep "${i} ")" ] && exit 1
done

true


#!/bin/bash

for i in redis-server ; do
	echo "Testing command ${i} is valid ..."
	type "${i}" &>/dev/null
done


#!/bin/bash

for i in killall ; do
	echo "Testing command ${i} is valid ..."
	type "${i}" &>/dev/null
done

true


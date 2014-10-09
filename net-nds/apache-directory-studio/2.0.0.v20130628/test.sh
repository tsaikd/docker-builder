#!/bin/bash

maxtime="$(( $(date +%s) + 60 ))"

for i in ApacheDirectoryStudio ; do
	echo "Testing command ${i} is valid ..."
	type "${i}" &>/dev/null
done

true


#!/bin/bash

maxtime="$(( $(date +%s) + 60 ))"

for i in docker wrapdocker ; do
	echo "Testing command ${i} is valid ..."
	type "${i}" &>/dev/null
done

true


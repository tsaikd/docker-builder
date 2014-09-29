#!/bin/bash

for i in jq remove-orphan-images.sh ; do
	echo "Testing command ${i} is valid ..."
	type "${i}" &>/dev/null
done

true


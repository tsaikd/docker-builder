#!/bin/bash

for i in virtualbox ; do
	echo "Testing command ${i} is valid ..."
	type "${i}" &>/dev/null
done

true


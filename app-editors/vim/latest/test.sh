#!/bin/bash

for i in vim ; do
	echo "Testing command ${i} is valid ..."
	type "${i}" &>/dev/null
done

true


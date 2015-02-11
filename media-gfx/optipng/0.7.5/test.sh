#!/bin/bash

for i in optipng ; do
	echo "Testing command ${i} is valid ..."
	type "${i}" &>/dev/null
done


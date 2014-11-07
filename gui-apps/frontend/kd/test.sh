#!/bin/bash

for i in sass gulp grunt bower ; do
	echo "Testing command ${i} is valid ..."
	type "${i}" &>/dev/null
done


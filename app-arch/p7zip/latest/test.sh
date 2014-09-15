#!/bin/bash

for i in 7z ; do
	echo "Testing command ${i} is valid ..."
	type "${i}" &>/dev/null
done

true


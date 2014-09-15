#!/bin/bash

for i in hg ; do
	echo "Testing command ${i} is valid ..."
	type "${i}" &>/dev/null
done

true


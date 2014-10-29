#!/bin/bash

for i in liteide ; do
	echo "Testing command ${i} is valid ..."
	type "${i}" &>/dev/null
done

true


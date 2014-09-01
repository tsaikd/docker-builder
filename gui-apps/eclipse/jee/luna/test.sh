#!/bin/bash

for i in eclipse ; do
	echo "Testing command ${i} is valid ..."
	type "${i}" &>/dev/null || exit 1
done

true


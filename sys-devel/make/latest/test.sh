#!/bin/bash

for i in make ; do
	echo "Testing command ${i} is valid ..."
	type "${i}" &>/dev/null
done


#!/bin/bash

for i in etherwake ; do
	echo "Testing command ${i} is valid ..."
	type "${i}" &>/dev/null
done


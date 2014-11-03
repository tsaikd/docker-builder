#!/bin/bash

for i in g++ ; do
	echo "Testing command ${i} is valid ..."
	type "${i}" &>/dev/null
done


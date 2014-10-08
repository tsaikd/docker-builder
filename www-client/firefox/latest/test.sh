#!/bin/bash

for i in firefox ; do
	echo "Testing command ${i} is valid ..."
	type "${i}" &>/dev/null
done


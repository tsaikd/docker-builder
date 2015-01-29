#!/bin/bash

for i in mongo ; do
	echo "Testing command ${i} is valid ..."
	type "${i}" &>/dev/null
done


#!/bin/bash

for i in unzip ; do
	echo "Testing command ${i} is valid ..."
	type "${i}" &>/dev/null
done

true


#!/bin/bash

for i in gor ; do
	echo "Testing command ${i} is valid ..."
	type "${i}" &>/dev/null
done

true


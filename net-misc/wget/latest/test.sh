#!/bin/bash

for i in wget ; do
	echo "Testing command ${i} is valid ..."
	type "${i}" &>/dev/null
done

true


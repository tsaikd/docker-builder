#!/bin/bash

for i in curl ; do
	echo "Testing command ${i} is valid ..."
	type "${i}" &>/dev/null
done

true


#!/bin/bash

for i in subl ; do
	echo "Testing command ${i} is valid ..."
	type "${i}" &>/dev/null
done

true


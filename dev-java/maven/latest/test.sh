#!/bin/bash

for i in mvn ; do
	echo "Testing command ${i} is valid ..."
	type "${i}" &>/dev/null
done

true


#!/bin/bash

for i in dig ; do
	echo "Testing command ${i} is valid ..."
	type "${i}" &>/dev/null
done

true


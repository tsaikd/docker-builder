#!/bin/bash

for i in ibus ; do
	echo "Testing command ${i} is valid ..."
	type "${i}" &>/dev/null
done


#!/bin/bash

for i in robomongo ; do
	echo "Testing command ${i} is valid ..."
	type "${i}" &>/dev/null
done


#!/bin/bash

for i in godep ; do
	echo "Testing command ${i} is valid ..."
	type "${i}" &>/dev/null
done

true


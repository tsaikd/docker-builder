#!/bin/bash

for i in google-chrome ; do
	echo "Testing command ${i} is valid ..."
	type "${i}" &>/dev/null
done


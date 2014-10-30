#!/bin/bash

for i in gradle ; do
	echo "Testing command ${i} is valid ..."
	type "${i}" &>/dev/null
done


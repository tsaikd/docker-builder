#!/bin/bash

for i in mount.ecryptfs ; do
	echo "Testing command ${i} is valid ..."
	type "${i}" &>/dev/null
done


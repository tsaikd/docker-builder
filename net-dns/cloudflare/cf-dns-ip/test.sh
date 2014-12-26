#!/bin/bash

for i in cf-dns-ip ; do
	echo "Testing command ${i} is valid ..."
	type "${i}" &>/dev/null || exit 1
done


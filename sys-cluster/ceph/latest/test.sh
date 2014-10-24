#!/bin/bash

for i in ceph-deploy ; do
	echo "Testing command ${i} is valid ..."
	type "${i}" &>/dev/null
done

true


#!/bin/bash

for i in java ; do
	echo "Testing command ${i} is valid ..."
	type "${i}" &>/dev/null || exit 1
done

echo "Testing java version ..."
[ -z "$(java -version 2>&1 | grep "1.6" | grep "java version")" ] && exit 1

true


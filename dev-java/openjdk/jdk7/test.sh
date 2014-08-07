#!/bin/bash

for i in java javac ; do
	echo "Testing command ${i} is valid ..."
	type "${i}" &>/dev/null || exit 1
done

echo "Testing java version ..."
[ -z "$(java -version 2>&1 | grep "1.7" | grep "java version")" ] && exit 1

echo "Testing javac version ..."
[ -z "$(javac -version 2>&1 | grep "javac 1.7")" ] && exit 1

true


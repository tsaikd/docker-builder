#!/bin/bash

for i in go ; do
	echo "Testing command ${i} is valid ..."
	type "${i}" &>/dev/null || exit 1
done

echo "Testing go version ..."
[ -z "$(go version 2>&1 | grep "go1.2")" ] && exit 1

true


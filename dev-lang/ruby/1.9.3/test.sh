#!/bin/bash

for i in ruby gem ; do
	echo "Testing command ${i} is valid ..."
	type "${i}" &>/dev/null || exit 1
done

echo "Testing go version ..."
[ -z "$(ruby -v 2>&1 | grep "ruby 1.9.3")" ] && exit 1

true


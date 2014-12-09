#!/bin/bash

for i in ruby gem ; do
	echo "Testing command ${i} is valid ..."
	type "${i}" &>/dev/null
done

echo "Testing ruby version ..."
[ -z "$(ruby -v 2>&1 | grep "ruby 1.9.3")" ] && exit 1


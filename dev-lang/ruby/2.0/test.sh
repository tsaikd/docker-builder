#!/bin/bash

for i in ruby ruby2.0 gem ; do
	echo "Testing command ${i} is valid ..."
	type "${i}" &>/dev/null
done

echo "Testing ruby version ..."
[ -z "$(ruby2.0 -v 2>&1 | grep "ruby 2.0")" ] && exit 1


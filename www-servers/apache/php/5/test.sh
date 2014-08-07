#!/bin/bash

for i in php ; do
	echo "Testing command ${i} is valid ..."
	type "${i}" &>/dev/null || exit 1
done

echo "Testing php version ..."
[ -z "$(php -v 2>&1 | grep "PHP 5")" ] && exit 1

true


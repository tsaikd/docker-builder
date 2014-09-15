#!/bin/bash

for i in php php5 ; do
	echo "Testing command ${i} is valid ..."
	type "${i}" &>/dev/null
done

echo "Testing php version ..."
[ -z "$(php -v 2>&1 | grep "PHP 5")" ] && exit 1

true


#!/bin/bash

for i in go ; do
	echo "Testing command ${i} is valid ..."
	type "${i}" &>/dev/null
done

echo "Testing go version ..."
[ -z "$(go version 2>&1 | grep "\\bgo${GO_VERSION}\\b")" ] && exit 1

true


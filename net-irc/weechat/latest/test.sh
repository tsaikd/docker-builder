#!/bin/bash

for i in weechat ; do
	echo "Testing command ${i} is valid ..."
	type "${i}" &>/dev/null
done


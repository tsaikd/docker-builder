#!/bin/bash

for i in hostapd; do
	echo "Testing command ${i} is valid ..."
	type "${i}" &>/dev/null
done

true


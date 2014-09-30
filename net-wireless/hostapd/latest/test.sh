#!/bin/bash

for i in hostapd dhcpd; do
	echo "Testing command ${i} is valid ..."
	type "${i}" &>/dev/null
done

true


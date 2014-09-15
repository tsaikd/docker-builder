#!/bin/bash

for i in openvpn easyrsa ; do
	echo "Testing command ${i} is valid ..."
	type "${i}" &>/dev/null
done

true


#!/bin/bash

for i in dhcpd syslogd; do
	echo "Testing command ${i} is valid ..."
	type "${i}" &>/dev/null
done

true


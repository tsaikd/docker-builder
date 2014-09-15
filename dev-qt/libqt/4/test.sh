#!/bin/bash

for i in g++ make qmake ; do
	echo "Testing command ${i} is valid ..."
	type "${i}" &>/dev/null
done

true


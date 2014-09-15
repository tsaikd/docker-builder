#!/bin/bash

for i in git ; do
	echo "Testing command ${i} is valid ..."
	type "${i}" &>/dev/null
done

true


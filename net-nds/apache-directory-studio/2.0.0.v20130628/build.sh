#!/bin/bash

if ! type ApacheDirectoryStudio &>/dev/null ; then
	tar xf "${DOCKER_SRC}/ApacheDirectoryStudio-linux-x86_64-2.0.0.v20130628.tar.gz" -C "/usr/local"
	ln -s "/usr/local/ApacheDirectoryStudio-linux-x86_64-2.0.0.v20130628/ApacheDirectoryStudio" "/usr/local/bin/"
fi


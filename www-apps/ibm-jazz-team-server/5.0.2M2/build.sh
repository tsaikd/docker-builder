#!/bin/bash

if [ ! -d "/opt/IBM/JazzTeamServer/server" ] ; then
	mkdir -p /opt/IBM/JazzTeamServer
	pushd /opt/IBM/JazzTeamServer
	unzip "${DOCKER_SRC}/JTS-CCM-keys-Linux64_5.0.2M2.zip"
	popd
fi


#!/bin/bash

mkdir -p "${TOMCAT_HOME}"
pushd "${TOMCAT_HOME}" >/dev/null

tar -xf "${DOCKER_SRC}/apache-tomcat-${TOMCAT_VERSION}.tar.gz" --strip-components=1

ln -s "${TOMCAT_HOME}/" "/var/lib/tomcat${TOMCAT_MAJOR}"
ln -s "${TOMCAT_HOME}/conf/" "/etc/tomcat${TOMCAT_MAJOR}"
ln -s "${TOMCAT_HOME}/logs/" "/var/log/tomcat${TOMCAT_MAJOR}"
ln -s "${TOMCAT_HOME}/work/" "/var/cache/tomcat${TOMCAT_MAJOR}"

popd >/dev/null


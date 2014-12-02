#!/bin/bash

solr_home="${SOLR_HOME:-multicore}"

pushd /usr/local/solr >/dev/null
if ! [ -d "${SOLR_HOME}" ] ; then
	solr_home="multicore"
fi

if [ "${DOCKER_BUILDING}" == "1" ] || [ "${SOLR_BACKGROUND}" == "1" ] ; then
	java ${SOLR_JAVA_OPTS} -Dsolr.solr.home="${solr_home}" -jar start.jar &
else
	exec java ${SOLR_JAVA_OPTS} -Dsolr.solr.home="${solr_home}" -jar start.jar
fi
popd >/dev/null


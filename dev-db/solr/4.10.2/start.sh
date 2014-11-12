#!/bin/bash

pushd /usr/local/solr >/dev/null
if [ -d "${SOLR_HOME}" ] ; then
	java ${SOLR_JAVA_OPTS} -Dsolr.solr.home="${SOLR_HOME}" -jar start.jar &
else
	java ${SOLR_JAVA_OPTS} -Dsolr.solr.home="multicore" -jar start.jar &
fi
popd >/dev/null


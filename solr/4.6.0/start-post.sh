#!/bin/bash

cd /usr/local/solr-4.6.0 || exit $?
if [ -d "$SOLR_HOME" ] ; then
	java ${SOLR_JAVA_OPTS} -Dsolr.solr.home=$SOLR_HOME -jar start.jar
else
	java ${SOLR_JAVA_OPTS} -Dsolr.solr.home=multicore -jar start.jar
fi


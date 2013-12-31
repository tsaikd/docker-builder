#!/bin/bash

source "$DOCKER_SRC/config.sh.sample"

if [ -f "$DOCKER_SRC/config.sh" ] ; then
	source "$DOCKER_SRC/config.sh"
fi

cd /usr/local/solr-4.6.0 || exit $?
if [ -d "$SOLR_HOME" ] ; then
	java ${SOLR_JAVA_OPTS} -Dsolr.solr.home=$SOLR_HOME -jar start.jar
else
	java ${SOLR_JAVA_OPTS} -Dsolr.solr.home=multicore -jar start.jar
fi


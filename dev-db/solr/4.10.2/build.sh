#!/bin/bash

solrver="4.10.2"

if [ ! -d "/usr/local/solr-${solrver}" ] ; then
	mkdir -p /tmp/solr

	tar -C /tmp/solr -xzf "${DOCKER_SRC}/solr-${solrver}.tgz"
	mv "/tmp/solr/solr-${solrver}/example" "/usr/local/solr-${solrver}"
	ln -sf "/usr/local/solr-${solrver}" "/usr/local/solr"

	rm -rf /tmp/solr
fi


#!/bin/bash

solrver="4.7.0"

mkdir -p /tmp/solr

tar -C /tmp/solr -xzf $DOCKER_SRC/solr-${solrver}.tgz
cp -a /tmp/solr/solr-${solrver}/example /usr/local/solr-${solrver}

rm -rf /tmp/solr


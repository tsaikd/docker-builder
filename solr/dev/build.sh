#!/bin/bash

source "$DOCKER_SRC/build-pre.sh"

solrver="4.6.0"

mkdir -p /tmp/solr

tar -C /tmp/solr -xzf $DOCKER_SRC/solr-${solrver}.tgz || exit $?
cp -a /tmp/solr/solr-${solrver}/example /usr/local/solr-${solrver} || exit $?

rm -rf /tmp/solr

source "$DOCKER_SRC/build-post.sh"


#!/bin/bash

apt-get -qq update || exit $?
apt-get -qq -y install tomcat7 tomcat7-admin || exit $?
apt-get -qq clean || exit $?

bash "$DOCKER_SRC/build-post.sh"


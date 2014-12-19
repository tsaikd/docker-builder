#!/bin/bash

mv "${DOCKER_SRC}/nexus-${NEXUS_VERSION}.war" /var/lib/tomcat7/webapps

mkdir -p /root/sonatype-work/nexus


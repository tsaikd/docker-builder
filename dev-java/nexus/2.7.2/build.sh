#!/bin/bash

ver="2.7.2"

mv "${DOCKER_SRC}/nexus-${ver}.war" /var/lib/tomcat7/webapps

mkdir -p /usr/share/tomcat7/sonatype-work/nexus

chown -R tomcat7:tomcat7 /usr/share/tomcat7/sonatype-work/nexus


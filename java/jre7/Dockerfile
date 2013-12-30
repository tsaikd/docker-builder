FROM DOCKER_BASE/ubuntu:12.04

MAINTAINER tsaikd "tsaikd@gmail.com"

ENV DOCKER_SRC /opt/docker/DOCKER_BASE/java-jre7

ADD . $DOCKER_SRC

RUN bash $DOCKER_SRC/build.sh

EXPOSE 80

CMD bash


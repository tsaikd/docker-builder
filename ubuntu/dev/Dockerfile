FROM DOCKER_BASE/ubuntu:12.04

MAINTAINER tsaikd "tsaikd@gmail.com"

ENV DOCKER_SRC /opt/docker/DOCKER_BASE/ubuntu-dev

ADD . $DOCKER_SRC

RUN bash $DOCKER_SRC/build.sh

CMD bash


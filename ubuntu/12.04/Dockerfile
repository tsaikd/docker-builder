FROM ubuntu:12.04

MAINTAINER tsaikd "tsaikd@gmail.com"

ENV DOCKER_SRC /opt/docker/DOCKER_BASE/ubuntu

ADD . $DOCKER_SRC

ENV HOME /root

RUN bash $DOCKER_SRC/build.sh

CMD bash


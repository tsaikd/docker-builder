FROM DOCKER_BASE/golang:1.2

MAINTAINER tsaikd "tsaikd@gmail.com"

ENV DOCKER_SRC /opt/docker/DOCKER_BASE/golang-dev

ADD . $DOCKER_SRC

RUN bash $DOCKER_SRC/build.sh

CMD bash


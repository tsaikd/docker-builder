FROM DOCKER_BASE/golang

MAINTAINER tsaikd "tsaikd@gmail.com"

ENV DOCKER_SRC /opt/docker/DOCKER_BASE/golang-dev

ADD . $DOCKER_SRC

RUN sh $DOCKER_SRC/build.sh

CMD ["/bin/bash"]


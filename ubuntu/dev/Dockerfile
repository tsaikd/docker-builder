FROM DOCKER_BASE/ubuntu

MAINTAINER tsaikd "tsaikd@gmail.com"

ENV DOCKER_SRC /opt/docker/DOCKER_BASE/ubuntu-dev

ADD . $DOCKER_SRC

RUN sh $DOCKER_SRC/build.sh

CMD ["/bin/bash"]


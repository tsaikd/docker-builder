FROM DOCKER_BASE/ubuntu:12.04

MAINTAINER tsaikd "tsaikd@gmail.com"

ENV DOCKER_SRC /opt/docker/DOCKER_BASE/java-jre7

ADD . $DOCKER_SRC

RUN sh $DOCKER_SRC/build.sh

EXPOSE 80

CMD ["/bin/bash"]


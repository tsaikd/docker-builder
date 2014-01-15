FROM DOCKER_BASE/ubuntu:12.04

MAINTAINER tsaikd "tsaikd@gmail.com"

ENV DOCKER_SRC /opt/docker/DOCKER_BASE/mysql

ADD . $DOCKER_SRC

RUN bash $DOCKER_SRC/build-all.sh

EXPOSE 3306

CMD bash $DOCKER_SRC/start-all.sh


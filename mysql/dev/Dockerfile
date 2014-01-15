FROM DOCKER_BASE/mysql:latest

MAINTAINER tsaikd "tsaikd@gmail.com"

ENV DOCKER_SRC /opt/docker/DOCKER_BASE/mysql-dev

ADD . $DOCKER_SRC

RUN bash $DOCKER_SRC/build-all.sh

EXPOSE 3306

CMD bash $DOCKER_SRC/start-all.sh


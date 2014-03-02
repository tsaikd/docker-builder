FROM DOCKER_BASE/nexus:2.7.2

MAINTAINER tsaikd "tsaikd@gmail.com"

ENV DOCKER_SRC /opt/docker/DOCKER_BASE/nexus-2.7.2-dev

EXPOSE 22
EXPOSE 8080

ADD . $DOCKER_SRC

RUN bash $DOCKER_SRC/build-all.sh

CMD bash $DOCKER_SRC/start-all.sh


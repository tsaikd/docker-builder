FROM DOCKER_BASE/java:jre7

MAINTAINER tsaikd "tsaikd@gmail.com"

ENV DOCKER_SRC /opt/docker/DOCKER_BASE/solr-4.6.0

ADD . $DOCKER_SRC

RUN bash $DOCKER_SRC/build.sh

EXPOSE 8080

CMD bash $DOCKER_SRC/start.sh


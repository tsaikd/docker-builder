FROM DOCKER_BASE/solr:4.6.0

MAINTAINER tsaikd "tsaikd@gmail.com"

ENV DOCKER_SRC /opt/docker/DOCKER_BASE/solr-4.6.0-dev

ADD . $DOCKER_SRC

RUN bash $DOCKER_SRC/build-all.sh

EXPOSE 8080

CMD bash $DOCKER_SRC/start-all.sh


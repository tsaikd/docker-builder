FROM DOCKER_BASE/elasticsearch:1.2.1

MAINTAINER tsaikd "tsaikd@gmail.com"

ENV DOCKER_SRC

EXPOSE 22
EXPOSE 9200
EXPOSE 9300

ADD . $DOCKER_SRC

RUN bash $DOCKER_SRC/build-all.sh

CMD bash $DOCKER_SRC/start-all.sh


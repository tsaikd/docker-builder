FROM DOCKER_BASE/dev-java/openjdk/jre7

MAINTAINER tsaikd "tsaikd@gmail.com"

ENV DOCKER_SRC

EXPOSE 8983

ADD . $DOCKER_SRC

RUN bash $DOCKER_SRC/build-all.sh

CMD bash $DOCKER_SRC/start-all.sh


FROM DOCKER_BASE/dev-java/openjdk/jdk7

MAINTAINER tsaikd "tsaikd@gmail.com"

ENV DOCKER_SRC

EXPOSE 22

VOLUME ["/root/workspace"]

ADD . $DOCKER_SRC

RUN bash $DOCKER_SRC/build-all.sh

CMD bash $DOCKER_SRC/start-all.sh


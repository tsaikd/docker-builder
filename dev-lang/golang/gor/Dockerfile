FROM DOCKER_BASE/dev-lang/golang/1.2

MAINTAINER tsaikd "tsaikd@gmail.com"

ENV DOCKER_SRC

ADD . $DOCKER_SRC

RUN bash $DOCKER_SRC/build-all.sh

CMD bash $DOCKER_SRC/start-all.sh


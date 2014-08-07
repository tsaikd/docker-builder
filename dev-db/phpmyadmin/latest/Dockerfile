FROM DOCKER_BASE/dev-db/mysql/latest

MAINTAINER tsaikd "tsaikd@gmail.com"

ENV DOCKER_SRC

EXPOSE 80
EXPOSE 3306

ADD . $DOCKER_SRC

RUN bash $DOCKER_SRC/build-all.sh

CMD bash $DOCKER_SRC/start-all.sh


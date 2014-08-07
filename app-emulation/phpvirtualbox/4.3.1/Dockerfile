FROM DOCKER_BASE/www-servers/apache/php/5

MAINTAINER tsaikd "tsaikd@gmail.com"

ENV DOCKER_SRC

EXPOSE 80

ADD . $DOCKER_SRC

RUN bash $DOCKER_SRC/build-all.sh

CMD bash $DOCKER_SRC/start-all.sh


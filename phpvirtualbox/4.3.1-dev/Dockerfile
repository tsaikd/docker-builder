FROM DOCKER_BASE/phpvirtualbox:4.3.1

MAINTAINER tsaikd "tsaikd@gmail.com"

ENV DOCKER_SRC /opt/docker/DOCKER_BASE/phpvirtualbox-4.3.1-dev

EXPOSE 22
EXPOSE 80

ADD . $DOCKER_SRC

RUN bash $DOCKER_SRC/build-all.sh

CMD bash $DOCKER_SRC/start-all.sh


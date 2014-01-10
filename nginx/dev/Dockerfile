FROM DOCKER_BASE/nginx:latest

MAINTAINER tsaikd "tsaikd@gmail.com"

ENV DOCKER_SRC /opt/docker/DOCKER_BASE/nginx-dev

ADD . $DOCKER_SRC

RUN bash $DOCKER_SRC/build.sh

EXPOSE 80

CMD bash $DOCKER_SRC/start.sh


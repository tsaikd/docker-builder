FROM DOCKER_BASE/nginx

MAINTAINER tsaikd "tsaikd@gmail.com"

ENV DOCKER_SRC /opt/docker/DOCKER_BASE/nginx-dev

ADD . $DOCKER_SRC

RUN sh $DOCKER_SRC/build.sh

EXPOSE 80

CMD ["nginx"]


FROM DOCKER_BASE/ubuntu

MAINTAINER tsaikd "tsaikd@gmail.com"

ENV DOCKER_SRC /opt/docker/DOCKER_BASE/nginx

ADD . $DOCKER_SRC

RUN sh $DOCKER_SRC/build.sh

EXPOSE 80

CMD ["nginx"]


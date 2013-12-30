FROM DOCKER_BASE/ubuntu:12.04

MAINTAINER tsaikd "tsaikd@gmail.com"

ENV DOCKER_SRC /opt/docker/DOCKER_BASE/nginx

ADD . $DOCKER_SRC

RUN bash $DOCKER_SRC/build.sh

EXPOSE 80

CMD service nginx start && tail -f /var/log/nginx/error.log


FROM DOCKER_BASE/ubuntu:stable

MAINTAINER tsaikd "tsaikd@gmail.com"

ENV DOCKER_SRC

EXPOSE 3128

ADD . $DOCKER_SRC

RUN bash $DOCKER_SRC/build-all.sh

CMD bash $DOCKER_SRC/start-all.sh

VOLUME ["/var/spool/squid3", "/var/log/squid3"]


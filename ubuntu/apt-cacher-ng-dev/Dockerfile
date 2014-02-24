FROM DOCKER_BASE/ubuntu:apt-cacher-ng

MAINTAINER tsaikd "tsaikd@gmail.com"

ENV DOCKER_SRC /opt/docker/DOCKER_BASE/ubuntu-apt-cacher-ng-dev

EXPOSE 22
EXPOSE 3142

ADD . $DOCKER_SRC

RUN bash $DOCKER_SRC/build-all.sh

CMD bash $DOCKER_SRC/start-all.sh


FROM DOCKER_BASE/tomcat:7

MAINTAINER tsaikd "tsaikd@gmail.com"

ENV DOCKER_SRC /opt/docker/DOCKER_BASE/tomcat7-dev

ADD . $DOCKER_SRC

RUN bash $DOCKER_SRC/build.sh

EXPOSE 8080

CMD bash $DOCKER_SRC/start.sh


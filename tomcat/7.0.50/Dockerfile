FROM DOCKER_BASE/java:jre7

MAINTAINER tsaikd "tsaikd@gmail.com"

ENV DOCKER_SRC /opt/docker/DOCKER_BASE/tomcat-7.0.50

ADD . $DOCKER_SRC

RUN bash $DOCKER_SRC/build-all.sh

EXPOSE 8080

CMD bash $DOCKER_SRC/start-all.sh


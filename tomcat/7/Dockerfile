FROM DOCKER_BASE/java:jre7

MAINTAINER tsaikd "tsaikd@gmail.com"

ENV DOCKER_SRC /opt/docker/DOCKER_BASE/tomcat7

ADD . $DOCKER_SRC

RUN bash $DOCKER_SRC/build.sh

EXPOSE 8080

CMD service tomcat7 start && tail -f /var/lib/tomcat7/logs/catalina.out


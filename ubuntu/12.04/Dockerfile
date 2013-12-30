FROM ubuntu:12.04

MAINTAINER tsaikd "tsaikd@gmail.com"

ENV DOCKER_SRC /opt/docker/DOCKER_BASE/ubuntu

ADD . $DOCKER_SRC

# env vars
ENV HOME /root

# apt
RUN echo 'Acquire::http::proxy "http://apt.tsaikd.org:9999";' > /etc/apt/apt.conf
RUN echo 'deb http://tw.archive.ubuntu.com/ubuntu/ precise main universe' > /etc/apt/sources.list

CMD ["/bin/bash"]


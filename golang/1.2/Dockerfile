FROM DOCKER_BASE/ubuntu

MAINTAINER tsaikd "tsaikd@gmail.com"

ENV DOCKER_SRC /opt/docker/DOCKER_BASE/golang

ADD . $DOCKER_SRC

# env vars
ENV GOPATH /opt/go
ENV PATH /opt/go/bin:/usr/local/go/bin:$PATH

# GOPATH
RUN mkdir -p /opt/go

# build.sh
RUN sh $DOCKER_SRC/build.sh

CMD ["/bin/bash"]


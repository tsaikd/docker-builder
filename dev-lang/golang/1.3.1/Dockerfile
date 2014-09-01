FROM DOCKER_BASE/ubuntu:stable

MAINTAINER tsaikd "tsaikd@gmail.com"

ENV DOCKER_SRC

ADD . $DOCKER_SRC

# env vars
ENV GOPATH /opt/go
ENV PATH /opt/go/bin:/usr/local/go/bin:$PATH

# GOPATH
RUN mkdir -p /opt/go

# build.sh
RUN bash $DOCKER_SRC/build-all.sh

CMD bash $DOCKER_SRC/start-all.sh


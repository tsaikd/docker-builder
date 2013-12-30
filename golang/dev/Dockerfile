FROM tsaikd/ubuntu:dev

MAINTAINER tsaikd "tsaikd@gmail.com"

ADD . /opt/docker/tsaikd/golang

# env vars
ENV GOPATH /opt/go
ENV PATH /opt/go/bin:/usr/local/go/bin:$PATH

# GOPATH
RUN mkdir -p /opt/go

# build.sh
RUN sh /opt/docker/tsaikd/golang/build.sh

CMD ["/bin/bash"]


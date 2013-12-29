FROM tsaikd/ubuntu

MAINTAINER tsaikd "tsaikd@gmail.com"

ADD . /opt/docker/tsaikd/golang

# env vars
ENV GOPATH /opt/go
ENV PATH /opt/go/bin:/usr/local/go/bin:$PATH

# GOPATH
RUN mkdir -p /opt/go

# apt
RUN apt-get update
RUN apt-get install -y build-essential mercurial git subversion wget

# go 1.2 tarball https://go.googlecode.com/files/go1.2.linux-amd64.tar.gz
RUN tar -C /usr/local -xzf /opt/docker/tsaikd/golang/go1.2.linux-amd64.tar.gz

CMD ["/bin/bash"]


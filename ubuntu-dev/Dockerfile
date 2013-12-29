FROM tsaikd/ubuntu

MAINTAINER tsaikd "tsaikd@gmail.com"

ADD . /opt/docker/tsaikd/ubuntu-dev

# apt
RUN apt-get update && apt-get dist-upgrade -y

# net-tools for ifconfig
# iputils-ping for ping
# vim for vi
# git for git
RUN apt-get install -y net-tools iputils-ping vim git

# install tsaikd bash
RUN cd $HOME && git clone https://github.com/tsaikd/bash .my-shell && bash $HOME/.my-shell/tools/install.sh

CMD ["/bin/bash"]


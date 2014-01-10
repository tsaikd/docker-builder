#!/bin/bash

source "$DOCKER_SRC/build-pre.sh"

# net-tools for ifconfig
# iputils-ping for ping
# vim for vi
# psmisc for killall
# wget for wget
# git for git
# openssh-server for sshd
apt-get -qq update || exit $?
apt-get -qq -y dist-upgrade || exit $?
apt-get -qq -y install net-tools iputils-ping vim wget psmisc git openssh-server || exit $?
apt-get -qq  clean || exit $?

# prepare ssh server
mkdir -p /var/run/sshd
chpasswd <<<"root:admin123"

# install tsaikd bash
git clone https://github.com/tsaikd/bash "${HOME}/.my-shell" || exit $?
bash "$HOME/.my-shell/tools/init.sh" || exit $?

source "$DOCKER_SRC/build-post.sh"


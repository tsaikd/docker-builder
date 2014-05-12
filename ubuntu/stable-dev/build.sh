#!/bin/bash

# vim for vim
# wget for wget
# psmisc for killall
# git for git
# openssh-server for sshd
apt-get -q update || exit $?
apt-get -q -y dist-upgrade || exit $?
apt-get -q -y install vim wget psmisc git openssh-server || exit $?
apt-get -q  clean || exit $?

# prepare ssh server
sed -i 's/^UsePAM yes/UsePAM no/' /etc/ssh/sshd_config || exit $?
mkdir -p /var/run/sshd
chpasswd <<<"root:${ROOT_PASSWD}"

# install tsaikd bash
git clone https://github.com/tsaikd/bash "${HOME}/.my-shell" || exit $?
bash "$HOME/.my-shell/tools/init.sh" || exit $?

# set environment for ssh
env >> /etc/environment


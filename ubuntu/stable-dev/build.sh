#!/bin/bash

# vim for vim
# wget for wget
# curl for curl
# psmisc for killall
# git for git
# openssh-server for sshd
apt-get -q -y dist-upgrade || exit $?
apt-get -q -y install vim wget curl psmisc git openssh-server || exit $?

# prepare ssh server
sed -i 's/^UsePAM yes/UsePAM no/' /etc/ssh/sshd_config || exit $?
mkdir -p /var/run/sshd
if [ "${ROOT_PASSWD}" ] && [ "${ROOT_PASSWD}" != "CHANGE_IT" ] ; then
	chpasswd <<<"root:${ROOT_PASSWD}"
fi

# install tsaikd bash
git clone https://github.com/tsaikd/bash "${HOME}/.my-shell" || exit $?
bash "$HOME/.my-shell/tools/init.sh" || exit $?
# disable auto update
echo "epoch_last=99999" > "${HOME}/.my-shell/.last-update"

# set environment for ssh
env >> /etc/environment


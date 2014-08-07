#!/bin/bash

apt-get -q -y install openssh-server || exit $?

# prepare ssh server
sed -i 's/^UsePAM yes/UsePAM no/' /etc/ssh/sshd_config || exit $?
mkdir -p /var/run/sshd
if [ "${ROOT_PASSWD}" ] && [ "${ROOT_PASSWD}" != "CHANGE_IT" ] ; then
	chpasswd <<<"root:${ROOT_PASSWD}"
fi

# set environment for ssh
env >> /etc/environment


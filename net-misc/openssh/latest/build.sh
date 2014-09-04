#!/bin/bash

if ! type sshd &>/dev/null ; then
	apt-get -q -y install openssh-server || exit $?

	# prepare ssh server
	sed -i 's/^UsePAM yes/UsePAM no/' /etc/ssh/sshd_config || exit $?
	mkdir -p /var/run/sshd
	if [ "${ROOT_PASSWD}" ] && [ "${ROOT_PASSWD}" != "CHANGE_IT" ] ; then
		chpasswd <<<"root:${ROOT_PASSWD}"
	fi

	# set environment for ssh
	set | grep "^DOCKER.*=" | sed 's/^/export /' >> /etc/profile.d/01-env.sh
	set | grep "^http_proxy=" | sed 's/^/export /' >> /etc/profile.d/01-env.sh
	set | grep "^https_proxy=" | sed 's/^/export /' >> /etc/profile.d/01-env.sh
fi

true


#!/bin/bash

if ! type sshd &>/dev/null ; then
	apt-get -q -y install openssh-server

	# prepare ssh server
	sed -i 's/^UsePAM yes/UsePAM no/' /etc/ssh/sshd_config
	mkdir -p /var/run/sshd
	if [ "${ROOT_PASSWD}" ] && [ "${ROOT_PASSWD}" != "CHANGE_IT" ] ; then
		chpasswd <<<"root:${ROOT_PASSWD}"
	fi
fi

true


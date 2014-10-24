#!/bin/bash

if [ "${http_proxy}" ] ; then
	echo "http_proxy = ${http_proxy}" >> /etc/wgetrc
fi

if [ "${https_proxy}" ] ; then
	echo "https_proxy = ${https_proxy}" >> /etc/wgetrc
fi

if [ "${APT_PROXY}" ] ; then
	echo "Acquire::http::proxy \"${APT_PROXY}\";" > /etc/apt/apt.conf
elif [ "${http_proxy}" ] ; then
	echo "Acquire::http::proxy \"${http_proxy}\";" > /etc/apt/apt.conf
fi

if [ -f "/usr/share/zoneinfo/${TIMEZONE}" ] ; then
	echo "${TIMEZONE}" > /etc/timezone
	dpkg-reconfigure --frontend noninteractive tzdata
fi

apt-get -q -y update

if ! type lsb_release &>/dev/null ; then
	apt-get -q -y install lsb-release
fi

if ! type udevadm &>/dev/null ; then
	apt-get -q -y install udev
fi

if ! type netstat &>/dev/null ; then
	apt-get -q -y install net-tools
fi

if ! type ceph-deploy &>/dev/null ; then
	cat > /etc/apt/sources.list.d/ceph.list <<EOF
deb http://ceph.com/debian/ $(lsb_release -sc) main
EOF

	apt-get -q -y update
	apt-get -q -y --force-yes install ceph-deploy
fi

if [ "${ROOT_PASSWD}" ] && [ "${ROOT_PASSWD}" != "CHANGE_IT" ] ; then
	chpasswd <<<"root:${ROOT_PASSWD}"
fi

if [ ! -f "${HOME}/.ssh/id_rsa" ] ; then
	ssh-keygen -f "${HOME}/.ssh/id_rsa" -N ""
	cat "${HOME}/.ssh/id_rsa.pub" >> "${HOME}/.ssh/authorized_keys"
	chmod 600 "${HOME}/.ssh/authorized_keys"
fi

ceph-deploy install "$(hostname)"

mkdir -p /var/lib/ceph/data/etc
rm -rf /etc/ceph
ln -s /var/lib/ceph/data/etc/ /etc/ceph

apt-get -q -y clean


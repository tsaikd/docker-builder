#!/bin/bash

if [ -d "${DOCKER_SRC}/root" ] ; then
	cp -aL "${DOCKER_SRC}/root/"* /
fi

touch /etc/apt/apt.conf
sed -i '/^Acquire::http::proxy /d' /etc/apt/apt.conf
if [ "${APT_PROXY}" ] ; then
	echo "Acquire::http::proxy \"${APT_PROXY}\";" >> /etc/apt/apt.conf
fi

if [ "${APT_SITE}" ] ; then
	sed -i "s|^deb\\(-src\\)\\? [^ ]* trusty\\(.*\\)$|deb\\1 ${APT_SITE} trusty\\2|g" /etc/apt/sources.list
fi

true


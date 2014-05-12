#!/bin/bash

if [ "${APT_PROXY}" ] ; then
	echo "Acquire::http::proxy \"${APT_PROXY}\";" > /etc/apt/apt.conf
fi

if [ "${APT_SITE}" ] ; then
	echo "deb ${APT_SITE} trusty main universe" > /etc/apt/sources.list
	echo "deb ${APT_SITE} trusty-updates main universe" >> /etc/apt/sources.list
	echo "deb ${APT_SITE} trusty-security main universe" >> /etc/apt/sources.list
fi

if [ -f "${TIMEZONE_PATH}" ] ; then
	cp -Lf "${TIMEZONE_PATH}" /etc/localtime
fi

locale-gen "${LANG}" || exit $?

dpkg-reconfigure locales || exit $?

update-locale LANG="${LANG}" || exit $?


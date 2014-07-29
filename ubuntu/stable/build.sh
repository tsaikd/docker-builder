#!/bin/bash

if [ "${APT_PROXY}" ] ; then
	echo "Acquire::http::proxy \"${APT_PROXY}\";" > /etc/apt/apt.conf
fi

if [ "${APT_SITE}" ] ; then
	echo "deb ${APT_SITE} trusty main universe" > /etc/apt/sources.list
	echo "deb ${APT_SITE} trusty-updates main universe" >> /etc/apt/sources.list
	echo "deb ${APT_SITE} trusty-security main universe" >> /etc/apt/sources.list
fi

if [ -f "/usr/share/zoneinfo/${TIMEZONE}" ] ; then
	echo "${TIMEZONE}" > /etc/timezone
	dpkg-reconfigure --frontend noninteractive tzdata || exit $?
fi

locale-gen "${LANG}" || exit $?

dpkg-reconfigure locales || exit $?

update-locale LANG="${LANG}" || exit $?


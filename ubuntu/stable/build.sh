#!/bin/bash

if [ "${APT_SITE}" ] ; then
	echo "deb ${APT_SITE} trusty main universe" > /etc/apt/sources.list
	echo "deb ${APT_SITE} trusty-updates main universe" >> /etc/apt/sources.list
	echo "deb ${APT_SITE} trusty-security main universe" >> /etc/apt/sources.list
fi

if [ -f "/usr/share/zoneinfo/${TIMEZONE}" ] ; then
	echo "${TIMEZONE}" > /etc/timezone
	dpkg-reconfigure --frontend noninteractive tzdata
fi

locale-gen "${LANG}"

dpkg-reconfigure locales

update-locale LANG="${LANG}"


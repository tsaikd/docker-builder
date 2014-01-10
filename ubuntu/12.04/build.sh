#!/bin/bash

if [ "${APT_PROXY}" ] ; then
	echo "Acquire::http::proxy \"${APT_PROXY}\";" > /etc/apt/apt.conf
fi

if [ "${APT_SITE}" ] ; then
	echo "deb ${APT_SITE} precise main universe" > /etc/apt/sources.list
fi


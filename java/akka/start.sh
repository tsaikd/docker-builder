#!/bin/bash

if [ -f "/RUNNING_PID" ] ; then
	pid="$(cat /RUNNING_PID)"
	[ ! -d "/proc/${pid}" ] && rm -f "/RUNNING_PID"
fi

if [ ! -f "/RUNNING_PID" ] ; then
	/usr/local/activator-1.2.1/activator ui -Dhttp.address=0.0.0.0 &
fi

true


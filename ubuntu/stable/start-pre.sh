#!/bin/bash

function wait_iface() {
	local iface="${1:-eth0}"
	local timeout="${2:-60}"
	local maxtime="$(( $(date +%s) + ${timeout} ))"

	if ! ifconfig "${iface}" >/dev/null 2>&1 ; then
		echo "Waiting interface '${iface}' ..."
		sleep 1
	fi

	while ! ifconfig "${iface}" >/dev/null 2>&1 ; do
		[ "$(date +%s)" -gt "${maxtime}" ] && return 1
		sleep 2
	done

	return 0
}

function docker_builder_trap_term() {
	echo "Send signal TERM to all subprocess ..."
	pkill -TERM -P $$
}

trap "docker_builder_trap_term" TERM

if [ -f /config.sh ] ; then
	source /config.sh
fi

if [ -d "$DOCKER_SRC/custom" ] ; then
	cp -aL "$DOCKER_SRC/custom/"* /
fi

if [ -f "/start-pre.sh" ] ; then
	source "/start-pre.sh"
fi


#!/bin/bash

if [ "${DOCKER_BUILDING}" == "1" ] ; then
	CONSUL_SERVER="1"
fi

if [ "${CONSUL_SERVER}" == "1" ] ; then
	CONSUL_OPT="${CONSUL_OPT} -server"
	if [ ! -d "/var/lib/consul/data/raft" ] && [ -z "${CONSUL_JOIN}" ] ; then
		CONSUL_OPT="${CONSUL_OPT} -bootstrap"
	fi
fi

[ "${CONSUL_JOIN}" ] && CONSUL_OPT="${CONSUL_OPT} -join ${CONSUL_JOIN}"

consul agent ${CONSUL_OPT} &


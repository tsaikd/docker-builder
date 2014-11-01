#!/bin/bash

set -e

PN="${BASH_SOURCE[0]##*/}"
PD="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

DOCKER_BUILDER_DIR="${DOCKER_BUILDER_DIR:-/usr/docker-builder}"
DOCKER_BUILDER_BIN="${DOCKER_BUILDER_BIN:-/usr/local/bin}"

if [ -d "${PD}/.git" ] && [ -f "${PD}/config.sh.sample" ] && [ -f "${PD}/build.sh" ] ; then
	sudo mkdir -p "${DOCKER_BUILDER_BIN}"
	sudo ln -sf "${PD}/build.sh" "${DOCKER_BUILDER_BIN}/docker-builder"
else
	sudo git clone https://github.com/tsaikd/docker-builder "${DOCKER_BUILDER_DIR}"
	sudo mkdir -p "${DOCKER_BUILDER_BIN}"
	sudo ln -sf "${DOCKER_BUILDER_DIR}/build.sh" "${DOCKER_BUILDER_BIN}/docker-builder"
fi


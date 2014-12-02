#!/bin/bash

if [ "${DOCKER_BUILDING}" == "1" ] || [ "${ES_BACKGROUND}" == "1" ] ; then
	elasticsearch -d
else
	exec elasticsearch
fi


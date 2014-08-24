dnsmasq
=======

Usage example:

* config.sh
	* `DOCKER_BASE=tsaikd`
* Docker host IP:
	* 192.168.0.1
* Startup script files:
	* /data/dnsmasq/custom/etc/dnsmasq.d/tsaikd
	```
	server=8.8.8.8
	addn-hosts=/hosts
	```
	* /data/dnsmasq/run.sh
	```
	#!/bin/bash

	PD="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
	DOCKER_CUSTOM="/opt/docker/tsaikd/net-dns/dnsmasq/latest/custom"

	name="$( basename "${PD}" )"

	docker start "${name}" 2>/dev/null || \
	docker run -itd --name "${name}" --hostname "${name}" --restart "on-failure:5" \
	    -p 192.168.0.1:53:53/udp \
	    -v "${PD}/custom:${DOCKER_CUSTOM}" \
	    -v "${PD}/hosts:/hosts" \
	    tsaikd/net-dns.dnsmasq:latest
	```
	* /data/hosts
	```
	192.168.0.1 docker-host
	```


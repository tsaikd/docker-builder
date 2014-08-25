dnsmasq
=======

Usage example:

* config.sh
	* `DOCKER_BASE=tsaikd`
* Docker host IP:
	* 192.168.0.1
* Startup script files:
	* /data/dnsmasq/dnsmasq.d/tsaikd
	```
	server=8.8.8.8
	addn-hosts=/hosts
	```
	* /data/dnsmasq/run.sh
	```
	#!/bin/bash

	PD="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
	buildpath="net-dns/dnsmasq/latest"
	fullimgtag="$(echo "${buildpath}" | sed -r 's/\/([^/]*?)$/:\1/; s/\//./g')"
	name="$( basename "${PD}" )"

	docker start "${name}" 2>/dev/null || \
	docker run -itd --name "${name}" --hostname "${name}" --restart "on-failure:5" \
	    -p 192.168.0.1:53:53/udp \
	    -v "${PD}/dnsmasq.d/tsaikd:/etc/dnsmasq/dnsmasq.d/tsaikd" \
	    -v "${PD}/hosts:/hosts" \
	    tsaikd/net-dns.dnsmasq:latest
	```
	* /data/dnsmasq/hosts
	```
	192.168.0.1 docker-host
	```

## Notes
* `-p 192.168.0.1:53:53/udp`
	* it's very important for network routing rule. it should not be `-p 53:53/udp`


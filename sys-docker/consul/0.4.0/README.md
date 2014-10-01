Consul
======

A tool for discovering and configuring services in your infrastructure.

## Quick Start

* Start a new consul datacenter
```
docker run -itP \
	-e CONSUL_SERVER="1" \
	tsaikd/sys-docker.consul:0.4.0
```

* Join an existed consul
```
docker run -itP \
	-e CONSUL_JOIN="192.168.0.1:8301" \
	tsaikd/sys-docker.consul:0.4.0
```

* Custom options via env `CONSUL_OPT`
```
docker run -itP \
	-e CONSUL_OPT="-server -bootstrap -advertise 192.168.0.1" \
	tsaikd/sys-docker.consul:0.4.0
```

## Reference

* [Official Site](http://www.consul.io/)


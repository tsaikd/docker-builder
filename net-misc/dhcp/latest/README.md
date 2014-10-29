A docker container for **dhcpd** (isc-dhcp-server).

## Quick Start

Blind start with most default settings:
```
docker run -t --net host net-misc.dhcp
```

A more customized example:
```
docker run -t --net host 
           -e INTERFACES=wlan0 \
           -e SUBNET="10.2.0.0" \
           -e RANGE="10.2.0.100 10.2.0.200" \
           -e ROUTER_IP="10.2.0.1" \
           net-misc.dhcp
```

## Configuration via Environment Variables

Available environment variables are:
* `INTERFACES` default to **ALL** interfaces (maybe dangerous in some cases)
* `SUBNET` with default `192.168.254.0`
* `RANGE` with default `"192.168.254.2 192.168.254.254"`
* `ROUTER_IP` with default `192.168.254.1`

A docker container for **hostapd**, i.e. a Linux soft AP.

## Quick Start

Blind start with most default settings:
```
docker run -t -e INTERFACE=wlan0 --privileged --net host net-wireless.hostapd
```

A more customized example:
```
docker run -t \
           -e INTERFACE=wlan0 \
           -e SSID=g7 \
           -e WPA_PASSPHRASE=passw0rd \
           -e OUTGOINGS=eth0,ppp0 \
           --privileged
           --net host
           --rm \
           net-wireless.hostapd
```

## Config via Environment Variables

There is only one necessary environment variable:
* INTERFACE

Other available environment variables are:
* SUBNET
* RANGE
* AP_ADDR
* SSID
* CHANNEL
* WPA_PASSPHRASE
* HW_MODE
* DRIVER

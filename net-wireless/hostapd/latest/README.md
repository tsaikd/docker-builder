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
           -e SSID=g8 \
           -e WPA_PASSPHRASE=passw0rd \
           -e OUTGOINGS=eth0,ppp0 \
           --privileged
           --net host
           --rm \
           net-wireless.hostapd
```

## Configuration via Environment Variables

There is only one necessary environment variable:
* INTERFACE

Other available environment variables are:
* `SUBNET` with default `192.168.254.0`
* `AP_ADDR` with default `192.168.254.1`
* `SSID` with default `g8`
* `CHANNEL` with default `11`
* `WPA_PASSPHRASE` with default `passw0rd`
* `HW_MODE` with default `g`
* `DRIVER` with default `nl80211`
* `OUTGOINGS` with default allowing traffics to **ALL** interfaces

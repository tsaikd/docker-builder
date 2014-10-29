#!/bin/bash

if ! type hostapd &>/dev/null ; then
    apt-get -q -y install hostapd iptables
fi

true

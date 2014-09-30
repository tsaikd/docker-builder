#!/bin/bash

if ! type hostapd &>/dev/null ; then
    apt-get -q -y install hostapd isc-dhcp-server iptables
    rm /etc/dhcp/dhcpd.conf
    mv /usr/sbin/dhcpd /bin/dhcpd
    # Workaround for AppArmor
    sed -i "s/\/usr\/sbin\/dhcpd/\/bin\/dhcpd/g" /etc/init.d/isc-dhcp-server
fi

true

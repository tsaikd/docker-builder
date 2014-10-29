#!/bin/bash

if ! type dhcpd &>/dev/null ; then
    apt-get -q -y install isc-dhcp-server syslogd
    rm /etc/dhcp/dhcpd.conf
    mv /usr/sbin/dhcpd /bin/dhcpd
    # Workaround for AppArmor
    sed -i "s/\/usr\/sbin\/dhcpd/\/bin\/dhcpd/g" /etc/init.d/isc-dhcp-server
fi

true

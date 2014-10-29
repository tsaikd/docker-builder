#!/bin/bash

function dhcpd_main() {
    # Default values
    true ${INTERFACES:=""}
    INTERFACES="$(sed 's/,\+/ /g' <<<"${INTERFACES}")"
    true ${SUBNET:=192.168.254.0}
    true ${RANGE:="192.168.254.2 192.168.254.254"}
    RANGE="$(sed 's/,\+/ /g' <<<"${RANGE}")"
    true ${ROUTER_IP:=192.168.254.1}

    # Set interfaces which dhcpd will listen on
    if [ "${INTERFACES}" ] ; then
        sed -i "s/^INTERFACES=\"\"/INTERFACES=\"${INTERFACES}\"/g" \
            /etc/default/isc-dhcp-server
    fi

    # Generate config file for dhcpd (isc-dhcp-server)
    mkdir -p "/etc/dhcp"
    if [ ! -f "/etc/dhcp/dhcpd.conf" ] ; then
        cat > "/etc/dhcp/dhcpd.conf" <<EOF
ddns-update-style none;
default-lease-time 600;
max-lease-time 7200;
log-facility local7;
subnet ${SUBNET} netmask 255.255.255.0 {
    range ${RANGE};
    option domain-name-servers 8.8.8.8, 168.95.192.1, 168.95.1.1;
    option routers ${ROUTER_IP};
}
EOF
    fi
}

if [ ! "${DOCKER_BUILDING}" ] ; then
    dhcpd_main
    service isc-dhcp-server restart
    syslogd &
    sleep 1 && tail -f /var/log/messages
fi

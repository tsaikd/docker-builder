#!/bin/bash

# Check if running in privileged mode
if [ ! -w "/sys" ] ; then
    echo "[Error] Not running in privileged mode."
fi

function hostapd_main() {
    # Default values
    true ${SUBNET:=192.168.254.0}
    true ${RANGE:="192.168.254.2 192.168.254.254"}
    RANGE="$(sed 's/,\+/ /g' <<<"${RANGE}")"
    true ${AP_ADDR:=192.168.254.1}
    true ${SSID:=g8}
    true ${CHANNEL:=11}
    true ${WPA_PASSPHRASE:=passw0rd}
    true ${HW_MODE:=g}
    true ${DRIVER:=nl80211}

    # Generate config file for hostapd
    mkdir -p "/etc/hostapd"
    if [ ! -f "/etc/hostapd/hostapd.conf" ] ; then
        cat > "/etc/hostapd/hostapd.conf" <<EOF
interface=${INTERFACE}
driver=${DRIVER}
ssid=${SSID}
hw_mode=${HW_MODE}
channel=${CHANNEL}
wpa=1
wpa_passphrase=${WPA_PASSPHRASE}
wpa_key_mgmt=WPA-PSK
wpa_pairwise=TKIP CCMP
wpa_ptk_rekey=600
EOF
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
    option routers ${AP_ADDR};
}
EOF
    fi

    # Setup interface and restart DHCP service 
    ip link set ${INTERFACE} up
    ip addr flush dev ${INTERFACE}
    ip addr add ${AP_ADDR}/24 dev ${INTERFACE}
    service isc-dhcp-server restart
    /usr/sbin/hostapd /etc/hostapd/hostapd.conf &

    # NAT settings
    echo "1" > /proc/sys/net/ipv4/ip_dynaddr
    echo "1" > /proc/sys/net/ipv4/ip_forward
    if [ "${OUTGOINGS}" ] ; then
        ints="$(sed 's/,\+/ /g' <<<"${OUTGOINGS}")"
        for int in ${ints}
        do
            echo "Setting iptables for outgoing traffics on ${int}..."
            iptables -t nat -D POSTROUTING -s ${SUBNET}/24 -o ${int} -j MASQUERADE || true
            iptables -t nat -A POSTROUTING -s ${SUBNET}/24 -o ${int} -j MASQUERADE
        done
    else
        echo "Setting iptables for outgoing traffics on all interfaces..."
        iptables -t nat -A POSTROUTING -s ${SUBNET}/24 -j MASQUERADE
    fi
}

# Check environment variables
if [ "${INTERFACE}" ] ; then
    hostapd_main
else
    echo "An interface must be specified, aborted!"
fi

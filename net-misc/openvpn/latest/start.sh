#!/bin/bash

true ${OVPN_PROTO:=tcp}

export EASYRSA="${EASYRSA:-/usr/local/easy-rsa/easyrsa3}"
export EASYRSA_PKI="${EASYRSA_PKI:-/etc/openvpn/pki}"
export EASYRSA_BATCH="true"

mkdir -p "/etc/openvpn"
if [ ! -f "/etc/openvpn/openvpn.conf" ] ; then
	cat > "/etc/openvpn/openvpn.conf" <<-EOF
server 192.168.255.0 255.255.255.0
verb 3
#duplicate-cn
key /etc/openvpn/pki/private/server.key
ca /etc/openvpn/pki/ca.crt
cert /etc/openvpn/pki/issued/server.crt
dh /etc/openvpn/pki/dh.pem
tls-auth /etc/openvpn/pki/ta.key
crl-verify /etc/openvpn/pki/crl.pem
key-direction 0
keepalive 10 60
comp-lzo
persist-key
persist-tun
push "dhcp-option DNS 168.95.1.1"
push "dhcp-option DNS 8.8.8.8"

proto ${OVPN_PROTO}
# Rely on Docker to do port mapping, internally always 1194
port 1194
dev tun0
status /tmp/openvpn-status.log

client-config-dir /etc/openvpn/ccd
	EOF
fi

if [ ! -d "/etc/openvpn/pki" ] ; then
	easyrsa init-pki

	easyrsa build-ca nopass

	easyrsa gen-dh

	easyrsa gen-crl

	openvpn --genkey --secret /etc/openvpn/pki/ta.key

	easyrsa build-server-full "server" nopass
fi

mkdir -p /etc/openvpn/ccd

if [ -w "/sys" ] ; then
	mkdir -p /dev/net
	if [ ! -c /dev/net/tun ]; then
	    mknod /dev/net/tun c 10 200
	fi

	iptables -t nat -A POSTROUTING -s 192.168.255.0/24 -o eth0 -j MASQUERADE

	openvpn --config "/etc/openvpn/openvpn.conf" &
else
	echo "Please run container in privileged mode!"
fi

true


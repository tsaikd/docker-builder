#!/bin/bash

if ! type openvpn &>/dev/null ; then
	apt-get -q -y install openvpn iptables git

	git clone "https://github.com/OpenVPN/easy-rsa" "/usr/local/easy-rsa"
	ln -s /usr/local/easy-rsa/easyrsa3/easyrsa /usr/local/bin/easyrsa
fi

true


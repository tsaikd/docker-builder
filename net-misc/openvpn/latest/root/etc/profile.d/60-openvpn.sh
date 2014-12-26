#!/bin/bash

export OVPN_PROTO="${OVPN_PROTO:-tcp}"
export EASYRSA="${EASYRSA:-/usr/local/easy-rsa/easyrsa3}"
export EASYRSA_PKI="${EASYRSA_PKI:-/etc/openvpn/pki}"
export EASYRSA_BATCH="true"


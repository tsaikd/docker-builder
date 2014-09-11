OpenVPN for Docker
==================

OpenVPN server in a Docker container complete with an EasyRSA PKI CA.

## Quick Start

* Prepare data storage in host folder

```
mkdir -p /data/ovpn-data
```

* Start OpenVPN server process

```
docker run -v "/data/ovpn-data:/etc/openvpn" \
	-d -p 1194:1194 --privileged tsaikd/net-misc.openvpn
```

* Generate a client certificate without a passphrase

```
docker run -v "/data/ovpn-data:/etc/openvpn" \
	--rm tsaikd/net-misc.openvpn easyrsa build-client-full CLIENTNAME nopass
```

* Retrieve the client configuration with embedded certificates

```
docker run -v "/data/ovpn-data:/etc/openvpn" \
	--rm tsaikd/net-misc.openvpn ovpn_getclient CLIENTNAME > CLIENTNAME.ovpn
```

* Revoke the client certificate

```
docker run -v "/data/ovpn-data:/etc/openvpn" \
	--rm tsaikd/net-misc.openvpn ovpn_revoke CLIENTNAME
```

## Reference

* https://github.com/kylemanna/docker-openvpn


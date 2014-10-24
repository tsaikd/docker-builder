#!/bin/bash

export SSH_PORT="${SSH_PORT:-22}"

mkdir -p /var/lib/ceph/data/deploy
mkdir -p /var/lib/ceph/data/etc
mkdir -p /var/lib/ceph/data/osd0

# fix bug in 0.80.5
mkdir -p /var/lib/ceph/osd

# change ssh server port
sed -i "s/^Port .*\$/Port ${SSH_PORT}/g" /etc/ssh/sshd_config
mkdir -p "${HOME}/.ssh"
cat >"${HOME}/.ssh/config" <<EOF
Host *
    StrictHostKeyChecking no
    Port ${SSH_PORT}
EOF

service ssh restart

cd /var/lib/ceph/data/deploy
[ -f "ceph.conf" ] && [ -f "ceph.client.admin.keyring" ] && {
	ceph-deploy --overwrite-conf admin $(hostname)
}

[ -f "/var/lib/ceph/data/etc/ceph.conf" ] && {
	service ceph start
}


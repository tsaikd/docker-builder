ceph
====

depend on debian

## docker command example
* keep deploy keyring and ceph data
```
docker run -it --net host \
	-v "/data/ceph:/var/lib/ceph" \
	tsaikd/sys-cluster.ceph:latest
```

* change SSH port if conflict with host (usually)
```
docker run -it --net host \
	-e SSH_PORT=2022 \
	-v "/data/ceph:/var/lib/ceph" \
	tsaikd/sys-cluster.ceph:latest
```

* use another ip bridged by pipework
```
docker run -it --name ceph-node --net none \
	-v "/data/ceph:/var/lib/ceph" \
	tsaikd/sys-cluster.ceph:latest
pipework eth0 -i eth0 ceph-node 192.168.0.100/24@192.168.0.1
```

* use /data0, /data1 for OSD
```
docker run -it --net host \
	-v "/data/ceph:/var/lib/ceph" \
	-e CEPH_OSD="/data0 /data1" -v "/data0:/data0" -v "/data1:/data1" \
	tsaikd/sys-cluster.ceph:latest
```

## ENV
* `SSH_PORT` : default 22
* `CEPH_OSD` : default /var/lib/ceph/data/osd0
* `HOST`     : ceph node FQDN, default is $HOSTNAME


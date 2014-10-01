docker
======

Some customizable Dockerfile scripts

## Global customization
* [Image]/[Tag]/root/
> Put build time customization file here will copy to container root ('/')
* [Image]/[Tag]/custom/
> Put run time customization file here will copy to container root ('/')

## Custom start script
* /start-pre.sh
> You can put custom start script in [Image]/[Tag]/root/ or [Image]/[Tag]/custom/
* /start.sh
> You can put custom start script in [Image]/[Tag]/root/ or [Image]/[Tag]/custom/

## Build images
Build ubuntu images on your local docker host.
```
./build.sh ubuntu/stable
```

## Supported images
```
./build.sh -l
```

## Run application example

* [net-dns/dnsmasq/latest](net-dns/dnsmasq/latest)
* [net-misc/openvpn/latest](net-misc/openvpn/latest)

```
docker run -itd -p 80:80 tsaikd/www-servers.nginx:latest
```

```
docker run -i -t -d -p 8080:8080 tsaikd/www-servers.tomcat:7
```

```
docker run -i -t -d -p 8080:8080 -v /data/webapps:/var/lib/tomcat7/webapps tsaikd/www-servers.tomcat:7
```

```
docker run -i -t -d -p 8983:8983 -v /data/solr:/data/solr tsaikd/dev-db.solr:4.7.0
```

## More customization
* config.sh (see config.sh.sample for more detail)

## Image structure
* Image name (ubuntu)
	* Tag name (stable)
		* Dockerfile (Dockerfile)
			* DOCKER_BASE will be replaced with DOCKER_BASE variable in config.sh
			* Put add build data to DOCKER_SRC in image file
		* Build image script (build.sh)
		* Default start CMD (start.sh)
		* Default test CMD (test.sh)
		* Inherit other images (inherit)
		* Download file list (download)
		* SHA1 hash checksum file (sha1sum)
		* Build time custom root filesystem (root)
		* Run time custom root filesystem (custom)
		* Before build image script, usually no need (build-pre.sh)
		* After build image script, usually no need (build-post.sh)
		* Before start CMD, usually no need (start-pre.sh)
		* After start CMD, usually no need (start-post.sh)
		* Before test CMD, usually no need (test-pre.sh)
		* After test CMD, usually no need (test-post.sh)
		* Final build image script, auto generate (build-all.sh)
			* Concat list
				* config.sh.sample
				* config.sh
				* build-pre.sh
				* build.sh
				* build-post.sh
		* Final start CMD, auto generate (start-all.sh)
			* Concat list
				* config.sh.sample
				* config.sh
				* start-pre.sh
				* parent dockers start.sh
				* start.sh
				* start-post.sh
		* Final test CMD, auto generate (test-all.sh)
			* Concat list
				* config.sh.sample
				* config.sh
				* test-pre.sh
				* parent dockers test.sh
				* test.sh
				* test-post.sh
	* Tag name suffix -dev (stable-dev)
		* Final build image script, auto generate (build-all.sh)
			* Concat list
				* config.sh.sample
				* config.sh
				* build-pre.sh
				* ubuntu/stable-dev/build.sh
				* build.sh
				* build-post.sh
		* Final start CMD, auto generate (start-all.sh)
			* Concat list
				* config.sh.sample
				* config.sh
				* start-pre.sh
				* ubuntu/stable-dev/start.sh
				* parent dockers start.sh
				* start.sh
				* start-post.sh
		* Final test CMD, auto generate (test-all.sh)
			* Concat list
				* config.sh.sample
				* config.sh
				* test-pre.sh
				* ubuntu/stable-dev/test.sh
				* parent dockers test.sh
				* test.sh
				* test-post.sh

## Config loading order
* ./config.sh.sample
* ./config.sh
* ./Image/config.sh
* ./Image/Tag/config.sh
* ./Image/Tag/root/config.sh
* ./Image/Tag/custom/config.sh
	* This config can change at run time, others are generated at build time

===========================

## Customization example
* I do not want the tomcat unpack wars in webapps.
	* write a script /docker-data/tomcat-7/custom/start-pre.sh
	```
	sed -i 's/unpackWARs="true"/unpackWARs="false"/' /etc/tomcat7/server.xml
	```
	* run docker, and mount into /opt/docker/tsaikd/tomcat-7/custom/start-pre.sh
	```
	docker run -i -t -d -p 8080 -v /docker-data/tomcat-7/custom:/opt/docker/tsaikd/tomcat-7/custom tsaikd/tomcat:7
	```

## Build script notes
* Use env `DOCKER_BUILDING` == 1 in start.sh test.sh to check if in building step


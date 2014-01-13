docker
======

Some customizable Dockerfile scripts

## Global customization
* [Image]/[Tag]/root/
> Put build time customization file here will copy to container root ('/')
* [Image]/[Tag]/custom/
> Put run time customization file here will copy to container root ('/')

## Build images
Build images on your local docker host.
```
sudo ./build.sh
```

## Supported images
```
./build.sh -h
```

## Run application example
```
docker run -i -t -d -p 80:80 tsaikd/nginx
```

```
docker run -i -t -d -p 8080:8080 tsaikd/tomcat:7
```

```
docker run -i -t -d -p 8080:8080 -v /data/webapps:/opt/docker/tsaikd/tomcat-7/custom/var/lib/tomcat7/webapps tsaikd/tomcat:7
```

```
docker run -i -t -d -p 8983:8983 -v /data/solr:/data/solr tsaikd/solr:4.6.0
```

## More customization
* config.sh (see config.sh.sample for more detail)

## Image structure
* Image name (ubuntu)
	* Tag name (12.04)
		* Dockerfile (Dockerfile)
			* DOCKER_BASE will be replaced with DOCKER_BASE variable in config.sh
			* Put add build data to DOCKER_SRC in image file
		* Build image script (build.sh)
		* Default start CMD (start.sh)
		* Download file list (download)
		* SHA1 hash checksum file (sha1sum)
		* Build time custom root filesystem (root)
		* Run time custom root filesystem (custom)
		* Before build image script, usually no need (build-pre.sh)
		* After build image script, usually no need (build-post.sh)
		* Before start CMD, usually no need (start-pre.sh)
		* After start CMD, usually no need (start-post.sh)
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
	* Tag name suffix -dev (12.04-dev)
		* Final build image script, auto generate (build-all.sh)
			* Concat list
				* config.sh.sample
				* config.sh
				* build-pre.sh
				* ubuntu/12.04-dev/build.sh
				* build.sh
				* build-post.sh
		* Final start CMD, auto generate (start-all.sh)
			* Concat list
				* config.sh.sample
				* config.sh
				* start-pre.sh
				* ubuntu/12.04-dev/start.sh
				* parent dockers start.sh
				* start.sh
				* start-post.sh

## Config loading order
* ./config.sh.sample
* ./config.sh
* ./Image/config.sh
* ./Image/Tag/config.sh
* ./Image/Tag/root/config.sh
* ./Image/Tag/custom/config.sh
	* This config can change at run time, others are generated at build time


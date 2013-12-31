docker
======

Some customizable Dockerfile scripts

## Global customization
* [Image]/[Tag]/root/
> put customization file here will copy to container root ('/')

## Build images
Build images on your local docker host.
```
./build.sh
```

## Supported images
* ubuntu
	* 12.04
	* dev
* golang
	* 1.2
* nginx
	* latest
* java
	* jre7
* tomcat
	* 7
* solr
	* 4.6.0

## Run application example
```
docker run -i -t -d -p 80:80 tsaikd/nginx
```

```
docker run -i -t -d -p 8080:8080 tsaikd/tomcat:7
```

```
docker run -i -t -d -p 8983:8983 -v /data/solr:/data/solr tsaikd/solr:4.6.0
```

## More customization
* config.sh (see config.sh.sample for more detail)


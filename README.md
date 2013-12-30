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
	* dev
* nginx
	* latest
	* dev
* java
	* jre7
* tomcat
	* 7
	* dev

## Run application example
```
docker run -i -t -d -p 80:80 tsaikd/nginx
```

```
docker run -i -t -d -p 8080:8080 tsaikd/tomcat:7
```

## More customization
* config.sh (see config.sh.sample for more detail)


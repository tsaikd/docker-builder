dind
====

Usage example:

* Startup script files:
	```
	docker run --privileged -it -p 2375 \
		tsaikd/sys-docker.dind:latest \
		--api-enable-cors=true \
		-H tcp://0.0.0.0:2375 \
		-H unix:///var/run/docker.sock
	```

* See [jpetazzo/dind](https://github.com/jpetazzo/dind) for more information


registry-cleaner
================

[docker-registry](https://github.com/docker/docker-registry) has no way to really remove data to release disk space, so it needs to remove data by 3rd script.

Usage example:

* Startup script files:
	```
	docker run -it --rm --volumes-from `MY-REGISTRY-CONTAINER` \
		-e STORAGE_PATH="/tmp/registry" \
		tsaikd/sys-docker.registry-cleaner:latest
	```

The script come from [qxo gist](https://gist.github.com/qxo/db0c31a67511625610f6)


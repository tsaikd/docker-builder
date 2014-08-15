Virtualbox in Docker
====================

* Requirement
	* privilege mode

```
docker run -itd -p 2222:22 --privileged=true tsaikd/app-emulation.virtualbox:4.3
```

* Limitation
	* Only one virtualbox in one Docker host
	* Need to recompile in different kernel version

* Use SSH X11 forwarding to access GUI

```
ssh root@localhost -X -p 2222 virtualbox
```


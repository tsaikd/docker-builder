rutorrent
=========

ruTorrent is a front-end for the popular Bittorrent client rtorrent.

## Usage
* fig.yml

```
rtorrent:
  image: tsaikd/net-p2p.rtorrent:latest
  interactive: true
  dns: 8.8.8.8

rutorrent:
  image: tsaikd/net-p2p.rutorrent:3.6
  interactive: true
  links:
    - rtorrent:rtorrent
  ports:
    - 80
```

* run rtorrent with scgi (.rtorrent.rc)

```
scgi_port = 0.0.0.0:5000
```


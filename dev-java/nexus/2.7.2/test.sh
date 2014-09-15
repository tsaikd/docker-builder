#!/bin/bash

url="http://localhost:8080/nexus-2.7.2/"
echo "Testing url ${url} is valid ..."
wget -q --spider --no-proxy "${url}"

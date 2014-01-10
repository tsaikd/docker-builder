#!/bin/bash

service nginx start

tail -f /var/log/nginx/error.log


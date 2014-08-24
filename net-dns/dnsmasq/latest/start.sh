#!/bin/bash

service dnsmasq restart || exit $?

true


#!/bin/bash

go get -u github.com/wendal/gor || exit $?

go install github.com/wendal/gor/gor || exit $?


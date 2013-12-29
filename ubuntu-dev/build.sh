#!/bin/bash

# net-tools for ifconfig
# iputils-ping for ping
# vim for vi
# git for git
apt-get update || exit $?
apt-get dist-upgrade -y || exit $?
apt-get install -y net-tools iputils-ping vim git || exit $?

# install tsaikd bash
git clone https://github.com/tsaikd/bash "${HOME}/.my-shell" || exit $?
sh "$HOME/.my-shell/tools/init.sh" || exit $?


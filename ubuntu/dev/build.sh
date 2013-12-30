#!/bin/bash

# net-tools for ifconfig
# iputils-ping for ping
# vim for vi
# wget for wget
# git for git
apt-get -qq update || exit $?
apt-get -qq -y dist-upgrade || exit $?
apt-get -qq -y install net-tools iputils-ping vim wget git || exit $?
apt-get -qq  clean || exit $?

# install tsaikd bash
git clone https://github.com/tsaikd/bash "${HOME}/.my-shell" || exit $?
sh "$HOME/.my-shell/tools/init.sh" || exit $?


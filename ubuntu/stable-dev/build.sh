#!/bin/bash

# install tsaikd bash
git clone https://github.com/tsaikd/bash "${HOME}/.my-shell"
bash "$HOME/.my-shell/tools/init.sh"
# disable auto update
echo "epoch_last=99999" > "${HOME}/.my-shell/.last-update"


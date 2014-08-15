#!/bin/bash

echo "Testing config ..."
[ -z "$(grep "Noto Sans Korean" "${HOME}/.fonts.conf")" ] && exit 1

true


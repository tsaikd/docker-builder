#!/bin/bash

echo "Testing config ..."
[ -z "$(grep "Noto Sans Japanese" "${HOME}/.fonts.conf")" ] && exit 1

true


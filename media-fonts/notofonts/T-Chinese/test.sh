#!/bin/bash

echo "Testing config ..."
[ -z "$(grep "Noto Sans T Chinese" "${HOME}/.fonts.conf")" ] && exit 1

true


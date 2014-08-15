#!/bin/bash

echo "Testing config ..."
[ -z "$(grep "Noto Sans S Chinese" "${HOME}/.fonts.conf")" ] && exit 1

true


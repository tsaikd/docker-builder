#!/bin/bash

if ! type google-chrome &>/dev/null ; then
	cat > /etc/apt/sources.list.d/google-chrome.list <<EOF
deb http://dl.google.com/linux/chrome/deb/ stable main
EOF

	apt-get -q -y update
	apt-get -q -y --force-yes install google-chrome-stable
fi


#!/bin/bash

# docker official ubuntu built-in apt clean patch
if [ ! -f "/etc/apt/apt.conf.d/docker-clean" ] ; then
	cat > /etc/apt/apt.conf.d/02nocache <<EOF
DPkg::Post-Invoke {"/bin/rm -f /var/cache/apt/archives/*.deb || true";};
EOF
fi

locale-gen ${LANG} ${SUPPORT_LANG}

dpkg-reconfigure locales

update-locale LANG="${LANG}"

if [ -f "/usr/share/zoneinfo/${TIMEZONE}" ] ; then
	echo "${TIMEZONE}" > /etc/timezone
	dpkg-reconfigure --frontend noninteractive tzdata
fi


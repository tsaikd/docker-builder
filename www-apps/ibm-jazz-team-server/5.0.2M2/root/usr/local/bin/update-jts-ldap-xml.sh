#!/bin/bash

set -e

pushd /opt/IBM/JazzTeamServer/server/tomcat

for i in $(find -iname *-LDAP*.xml) ; do
	mv -v "${i}" "$(sed 's/-LDAP[0-9]*//' <<<"${i}")"
done

popd


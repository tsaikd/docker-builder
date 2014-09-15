#!/bin/bash

apt-get -q -y install tomcat7 tomcat7-admin

cat > "/etc/tomcat7/tomcat-users.xml" <<EOF
<?xml version='1.0' encoding='utf-8'?>
<tomcat-users>
  <role rolename="manager-gui"/>
  <role rolename="manager-script"/>
  <role rolename="admin-gui"/>
  <user username="${TOMCAT_ADMIN_NAME}" password="${TOMCAT_ADMIN_PASSWORD}" roles="manager-gui,manager-script,admin-gui"/>
</tomcat-users>
EOF

rm -f /var/log/tomcat7/*


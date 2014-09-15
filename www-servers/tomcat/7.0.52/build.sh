#!/bin/bash

ver="7.0.52"

tar -C /usr/local -xzf $DOCKER_SRC/apache-tomcat-$ver.tar.gz

mv /usr/local/apache-tomcat-$ver/conf /etc/tomcat7
mv /usr/local/apache-tomcat-$ver/logs /var/log/tomcat7
mv /usr/local/apache-tomcat-$ver/work /var/cache/tomcat7
mv /usr/local/apache-tomcat-$ver /var/lib/tomcat7

cd /var/lib/tomcat7

ln -s /etc/tomcat7 conf
ln -s ../../log/tomcat7 logs
ln -s ../../cache/tomcat7 work

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


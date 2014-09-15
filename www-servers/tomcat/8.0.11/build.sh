#!/bin/bash

ver="8.0.11"

tar -C /usr/local -xzf $DOCKER_SRC/apache-tomcat-$ver.tar.gz

mv /usr/local/apache-tomcat-$ver/conf /etc/tomcat8
mv /usr/local/apache-tomcat-$ver/logs /var/log/tomcat8
mv /usr/local/apache-tomcat-$ver/work /var/cache/tomcat8
mv /usr/local/apache-tomcat-$ver /var/lib/tomcat8

cd /var/lib/tomcat8

ln -s /etc/tomcat8 conf
ln -s ../../log/tomcat8 logs
ln -s ../../cache/tomcat8 work

cat > "/etc/tomcat8/tomcat-users.xml" <<EOF
<?xml version='1.0' encoding='utf-8'?>
<tomcat-users>
  <role rolename="manager-gui"/>
  <role rolename="manager-script"/>
  <role rolename="admin-gui"/>
  <user username="${TOMCAT_ADMIN_NAME}" password="${TOMCAT_ADMIN_PASSWORD}" roles="manager-gui,manager-script,admin-gui"/>
</tomcat-users>
EOF

rm -f /var/log/tomcat8/*


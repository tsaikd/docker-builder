#!/bin/bash

ver="8.0.11"

tar -C /usr/local -xzf $DOCKER_SRC/apache-tomcat-$ver.tar.gz || exit $?

mv /usr/local/apache-tomcat-$ver/conf /etc/tomcat8 || exit $?
mv /usr/local/apache-tomcat-$ver/logs /var/log/tomcat8 || exit $?
mv /usr/local/apache-tomcat-$ver/work /var/cache/tomcat8 || exit $?
mv /usr/local/apache-tomcat-$ver /var/lib/tomcat8 || exit $?

cd /var/lib/tomcat8 || exit $?

ln -s /etc/tomcat8 conf || exit $?
ln -s ../../log/tomcat8 logs || exit $?
ln -s ../../cache/tomcat8 work || exit $?

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


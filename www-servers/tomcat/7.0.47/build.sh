#!/bin/bash

ver="7.0.47"

tar -C /usr/local -xzf $DOCKER_SRC/apache-tomcat-$ver.tar.gz || exit $?

mv /usr/local/apache-tomcat-$ver/conf /etc/tomcat7 || exit $?
mv /usr/local/apache-tomcat-$ver/logs /var/log/tomcat7 || exit $?
mv /usr/local/apache-tomcat-$ver/work /var/cache/tomcat7 || exit $?
mv /usr/local/apache-tomcat-$ver /var/lib/tomcat7 || exit $?

cd /var/lib/tomcat7 || exit $?

ln -s /etc/tomcat7 conf || exit $?
ln -s ../../log/tomcat7 logs || exit $?
ln -s ../../cache/tomcat7 work || exit $?

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


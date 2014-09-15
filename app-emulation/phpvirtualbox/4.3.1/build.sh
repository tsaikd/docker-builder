#!/bin/bash

# phpvirtualbox 4.3-1 tarball http://sourceforge.net/projects/phpvirtualbox/files/phpvirtualbox-4.3-1.zip/download
cd /tmp
7z x "$DOCKER_SRC/phpvirtualbox-4.3-1.zip"
mv phpvirtualbox-4.3-1/* /var/www/html/
rmdir phpvirtualbox-4.3-1

cd /var/www/html
cp -a config.php-example config.php
sed -i "s/^\(var \$username = '\)\(\S*\)'/\1${PHPVIRTUALBOX_RUN_USER}'/" config.php
sed -i "s/^\(var \$password = '\)\(\S*\)'/\1${PHPVIRTUALBOX_RUN_PASS}'/" config.php
sed -i "s|^\(var \$location = '\)\(\S*\)'|\1${PHPVIRTUALBOX_VBOXWEBSRV_URL}'|" config.php


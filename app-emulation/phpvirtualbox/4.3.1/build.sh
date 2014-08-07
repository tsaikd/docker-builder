#!/bin/bash

# phpvirtualbox 4.3-1 tarball http://sourceforge.net/projects/phpvirtualbox/files/phpvirtualbox-4.3-1.zip/download
cd /tmp || exit $?
7z x "$DOCKER_SRC/phpvirtualbox-4.3-1.zip" || exit $?
mv phpvirtualbox-4.3-1/* /var/www/html/ || exit $?
rmdir phpvirtualbox-4.3-1 || exit $?

cd /var/www/html || exit $?
cp -a config.php-example config.php || exit $?
sed -i "s/^\(var \$username = '\)\(\S*\)'/\1${PHPVIRTUALBOX_RUN_USER}'/" config.php || exit $?
sed -i "s/^\(var \$password = '\)\(\S*\)'/\1${PHPVIRTUALBOX_RUN_PASS}'/" config.php || exit $?
sed -i "s|^\(var \$location = '\)\(\S*\)'|\1${PHPVIRTUALBOX_VBOXWEBSRV_URL}'|" config.php || exit $?


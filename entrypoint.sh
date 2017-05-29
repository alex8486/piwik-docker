#!/bin/bash
export USER_ID=$(id -u)
export GROUP_ID=$(id -g)
envsubst < /workdir/passwd.template > /tmp/passwd
export LD_PRELOAD=libnss_wrapper.so
export NSS_WRAPPER_PASSWD=/tmp/passwd
export NSS_WRAPPER_GROUP=/etc/group


if [ $IS_ALREADY_INSTALLED == TRUE ]; then

  mkdir -p /var/www/piwik/config/
  cp /workdir/config/config.ini.php /var/www/piwik/config/

  sed -i "s/DATABASE_HOST/${DATABASE_HOST}/g" /var/www/piwik/config/config.ini.php
  sed -i "s/DATABASE_USERNAME/${DATABASE_USERNAME}/g" /var/www/piwik/config/config.ini.php
  sed -i "s/DATABASE_PASSWORD/${DATABASE_PASSWORD}/g" /var/www/piwik/config/config.ini.php
  sed -i "s/DATABASE_NAME/${DATABASE_NAME}/g" /var/www/piwik/config/config.ini.php
  sed -i "s/PIWIK_URL/${PIWIK_URL}/g" /var/www/piwik/config/config.ini.php

fi

sed -i "s/ALLOWED_HOSTNAME/${ALLOWED_HOSTNAME}/g" /etc/nginx/conf.d/default.conf

if [ ! -f /var/www/piwik/index.php ]; then
  # Copy initial site
  mv /workdir/piwik/* /var/www/piwik/
fi

exec "/usr/bin/supervisord"

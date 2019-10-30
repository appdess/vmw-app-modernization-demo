#!/bin/bash
set -e

# Note: we don't just use "apache2ctl" here because it itself is just a shell-script wrapper around apache2 which provides extra functionality like "apache2ctl start" for launching apache2 in the background.
# (also, when run as "apache2ctl <apache args>", it does not use "exec", which leaves an undesirable resident shell process)

: "${APACHE_CONFDIR:=/etc/apache2}"
: "${APACHE_ENVVARS:=$APACHE_CONFDIR/envvars}"
if test -f "$APACHE_ENVVARS"; then
        . "$APACHE_ENVVARS"
fi

# Apache gets grumpy about PID files pre-existing
: "${APACHE_PID_FILE:=${APACHE_RUN_DIR:=/var/run/apache2}/apache2.pid}"
rm -f "$APACHE_PID_FILE"

#if it's running in a kubernetes environement
echo "<IfModule env_module>" > /etc/apache2/mods-enabled/env.conf
if [ -n "$TITO_SQL_SERVICE_SERVICE_HOST" ]; then
  echo "  SetEnv TITO-SQL $TITO_SQL_SERVICE_SERVICE_HOST" >> /etc/apache2/mods-enabled/env.conf
else
  echo "  SetEnv TITO-SQL Tito-SQL" >> /etc/apache2/mods-enabled/env.conf
fi

if [ -n "$PROXY_NAME" ]; then
  echo "  SetEnv proxy_name $PROXY_NAME" >> /etc/apache2/mods-enabled/env.conf
  echo "  setEnv proxy_port $PROXY_PORT" >> /etc/apache2/mods-enabled/env.conf
fi
echo "</IfModule>" >> /etc/apache2/mods-enabled/env.conf

#get Tito code
if [ -z "$(ls -A /var/www/html)" ]; then
	git clone https://github.com/appdess/Tito.git /var/www/html/
  rm -Rf /var/www/html/asset/Deployment /var/www/html/.gitignore
fi

# Make sure the config file has the updated password:
if [ -n "$MYSQL_ROOT_PASSWORD" ]; then
  sed -i "s/.*password.*/password = \"$MYSQL_ROOT_PASSWORD\"/" "/var/www/html/config.ini.php"
fi

#to have the apache server redirect the flow for ingress
sed -i '/<IfModule alias_module>/a Alias /tito/ "/var/www/html/"' /etc/apache2/mods-enabled/alias.conf

exec apache2 -DFOREGROUND "$@"

#!/bin/sh

mysqldump -u $MYSQL_USER -p$MYSQL_PASSWORD -h $MYSQL_HOST $MYSQL_STAGING_DATABASE > /backups/staging/$MYSQL_STAGING_DATABASE-$(date +\%A).sql
echo "$MYSQL_STAGING_DATABASE-$(date +%A%d%m%Y)"

# Call command issued to the docker service
exec "$@"

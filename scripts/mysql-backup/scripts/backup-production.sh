#!/bin/sh

mysqldump -u $MYSQL_USER -p$MYSQL_PASSWORD -h $MYSQL_HOST $MYSQL_PRODUCTION_DATABASE > /backups/production/$MYSQL_PRODUCTION_DATABASE-$(date +\%A).sql
echo "$MYSQL_PRODUCTION_DATABASE-$(date +%A%d%m%Y)"

# Call command issued to the docker service
exec "$@"

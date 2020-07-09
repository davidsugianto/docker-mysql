#!/bin/sh

crontab -l > backupcron

echo "0 0 * * * mysqldump -u $MYSQL_USER -p$MYSQL_PASSWORD -h $MYSQL_HOST $MYSQL_STAGING_DATABASE > /backups/staging/$MYSQL_STAGING_DATABASE-$(date +\%A).sql" >> backupcron
echo "0 0 * * * mysqldump -u $MYSQL_USER -p$MYSQL_PASSWORD -h $MYSQL_HOST $MYSQL_PRODUCTION_DATABASE > /backups/production/$MYSQL_PRODUCTION_DATABASE-$(date +\%A).sql" >> backupcron

export today="$(date +\%A)"
sed -i 's/'"$today"'/$(date +\%A)/' backupcron

crontab backupcron

echo "Cron job Database Backup is Completed"

# Call command issued to the docker service
exec "$@"

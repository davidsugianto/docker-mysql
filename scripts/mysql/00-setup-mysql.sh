#!/bin/sh

create_database() {
  local database=$1
  echo "Creating database '$database'"
  mysql --user=root --password=${MYSQL_ROOT_PASSWORD} <<-EOSQL
    CREATE DATABASE $database;
EOSQL
}

if [ -e "/home/mysql/staging/${MYSQL_STAGING_DATABASE}-$(date +\%A).sql" -a -e "/home/mysql/production/${MYSQL_PRODUCTION_DATABASE}-$(date +\%A).sql" ]; then
  echo "Database is ready to import"
  if [ -n "$MYSQL_MULTIPLE_DATABASE" ]; then
    echo "Multiple database creation requested: $MYSQL_MULTIPLE_DATABASE"
    for db in $(echo $MYSQL_MULTIPLE_DATABASE | tr ',' ' '); do
      create_database $db
    done
    echo "Add Permission Database ${MYSQL_STAGING_DATABASE} to ${MYSQL_USER} "
    mysql --user=root --password=${MYSQL_ROOT_PASSWORD} --execute="GRANT ALL ON ${MYSQL_STAGING_DATABASE}.* TO '${MYSQL_USER}';"
    echo "Add Permission Database ${MYSQL_PRODUCTION_DATABASE} to ${MYSQL_USER} "
    mysql --user=root --password=${MYSQL_ROOT_PASSWORD} --execute="GRANT ALL ON ${MYSQL_PRODUCTION_DATABASE}.* TO '${MYSQL_USER}';"
    echo "Importing Database Staging"
    cd /home/mysql/staging
    mysql --user=${MYSQL_USER} --password=${MYSQL_PASSWORD} ${MYSQL_STAGING_DATABASE} < ${MYSQL_STAGING_DATABASE}-$(date +\%A).sql
    echo "Importing Database Production"
    cd /home/mysql/production
    mysql --user=${MYSQL_USER} --password=${MYSQL_PASSWORD} ${MYSQL_PRODUCTION_DATABASE} < ${MYSQL_PRODUCTION_DATABASE}-$(date +\%A).sql
    echo "Importing success and database is ready"
  fi
else 
  echo "Database is not ready to import"
  if [ -n "$MYSQL_MULTIPLE_DATABASE" ]; then
    echo "Multiple database creation requested: $MYSQL_MULTIPLE_DATABASE"
    for db in $(echo $MYSQL_MULTIPLE_DATABASE | tr ',' ' '); do
      create_database $db
    done
    echo "Add Permission Database ${MYSQL_STAGING_DATABASE} to ${MYSQL_USER} "
    mysql --user=root --password=${MYSQL_ROOT_PASSWORD} --execute="GRANT ALL ON ${MYSQL_STAGING_DATABASE}.* TO '${MYSQL_USER}';"
    echo "Add Permission Database ${MYSQL_PRODUCTION_DATABASE} to ${MYSQL_USER} "
    mysql --user=root --password=${MYSQL_ROOT_PASSWORD} --execute="GRANT ALL ON ${MYSQL_PRODUCTION_DATABASE}.* TO '${MYSQL_USER}';"
    echo "Database is ready"
  fi
fi

# Call command issued to the docker service
exec "$@"

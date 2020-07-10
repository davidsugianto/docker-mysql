FROM idiots718/mysql-client:ubuntu-18.04

LABEL maintainer David Sugianto <idiots718@gmail.com>

ENV MYSQL_USER=${MYSQL_USER} \
    MYSQL_PASSWORD=${MYSQL_PASSWORD} \
    MYSQL_HOST=${MYSQL_HOST} \
    MYSQL_STAGING_DATABASE=${MYSQL_STAGING_DATABASE} \
    MYSQL_PRODUCTION_DATABASE=${MYSQL_PRODUCTION_DATABASE}

RUN mkdir -p /backups/staging && chmod -R 777 /backups/staging
RUN mkdir -p /backups/production && chmod -R 777 /backups/production
RUN chmod -R 777 /backups

COPY ./scripts /scripts
RUN find /scripts -type f -iname "*.sh" -exec chmod a+x {} \;
VOLUME /backups

ENTRYPOINT ["/scripts/entrypoint.sh"]


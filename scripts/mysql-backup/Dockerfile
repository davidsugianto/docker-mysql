FROM idiots718/mysql-client:ubuntu-18.04

LABEL maintainer David Sugianto <idiots718@gmail.com>

ARG MYSQL_USER
ARG MYSQL_PASSWORD
ARG MYSQL_HOST
ARG MYSQL_STAGING_DATABASE
ARG MYSQL_PRODUCTION_DATABASE

RUN mkdir -p /backups/staging && chmod -R 777 /backups/staging
RUN mkdir -p /backups/production && chmod -R 777 /backups/production
RUN chmod -R 777 /backups

COPY ./scripts /scripts
RUN find /scripts -type f -iname "*.sh" -exec chmod a+x {} \;
RUN /scripts/entrypoint.sh
VOLUME /backups

RUN service cron start

ENTRYPOINT ["top", "-b"]


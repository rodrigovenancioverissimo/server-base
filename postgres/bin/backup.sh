#!/bin/bash
# stop on errors
set -e

# we might run into trouble when using the default `postgres` user, e.g. when dropping the postgres
# database in restore.sh. Check that something else is used here
if [ "$POSTGRES_USER" == "postgres" ]
then
    echo "creating a backup as the postgres user is not supported, make sure to set the POSTGRES_USER environment variable"
    exit 1
fi

# export the postgres password so that subsequent commands don't ask for it
export PGPASSWORD=$POSTGRES_PASSWORD

echo "creating backup"
echo "---------------"

FILENAME=backup_$(date +'%Y_%m_%dT%H_%M_%S').sql.gz
pg_dump -h db-avanci -U avanci avancidb > /backups/$FILENAME

echo "successfully created backup $FILENAME"
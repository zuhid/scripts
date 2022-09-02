#!/bin/bash
# time ./rebuild-progressdb.sh

from_server='FROM_SERVER'
from_username='FROM_USERNAME'
from_password='FROM_PASSWORD'

to_server='TO_SERVER'
to_username='TO_USERNAME'
to_password='TO_PASSWORD'

databaseNameExt="_prod"
databaseList=(
  'database_1'
  'database_2'
  'database_3'
)

# backup database
# $1 = database
backup() {
  export PGPASSWORD=$from_password
  pg_dump \
    --host $from_server \
    --username $from_username \
    $1 >output/$1.sql
}

# rebuild database
# $1 = database
rebuild() {
  export PGPASSWORD=$to_password
  newDatabaseName=$1$databaseNameExt
  # terminate connections to the database
  psql \
    --host $to_server \
    --username $to_username \
    --quiet \
    --command "SELECT pg_terminate_backend(pg_stat_activity.pid)
FROM pg_stat_activity
WHERE pg_stat_activity.datname = '$1'
AND pid <> pg_backend_pid();"

  # drop the database
  dropdb --username $to_username $newDatabaseName

  #create the database
  createdb --username $to_username $newDatabaseName

  #  rebuild the database
  psql \
    --host $to_server \
    --username $to_username \
    --dbname $newDatabaseName \
    --quiet \
    --file output/$1.sql

  # run any post build script
  export PGPASSWORD=$to_password
  psql \
    --host $to_server \
    --username $to_username \
    --dbname $newDatabaseName \
    --quiet \
    --file postBuild/$1.sql
}

mkdir output 2>/dev/null  # create the output folder
for database in "${databaseList[@]}"; do
  # backup $database # backup production database
  rebuild $database # rebuild local database
done

unset PGPASSWORD # remove environment variables for the password

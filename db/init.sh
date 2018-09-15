#!/bin/bash

ROOT_DIR=$(cd $(dirname $0)/..; pwd)
DB_DIR="$ROOT_DIR/db"
BENCH_DIR="$ROOT_DIR/bench"

export MYSQL_PWD=$DB_PASS

mysql --host "$DB_HOST" -u"$DB_USER" -e "DROP DATABASE IF EXISTS $DB_DATABASE; CREATE DATABASE $DB_DATABASE;"
mysql --host "$DB_HOST" -u"$DB_USER" "$DB_DATABASE" < "$DB_DIR/schema.sql"

if [ ! -f "$DB_DIR/isucon8q-initial-dataset.sql.gz" ]; then
  echo "Run the following command beforehand." 1>&2
  echo "$ ( cd \"$BENCH_DIR\" && bin/gen-initial-dataset )" 1>&2
  exit 1
fi

mysql --host "$DB_HOST" -u"$DB_USER" "$DB_DATABASE" -e 'ALTER TABLE reservations DROP KEY event_id_and_sheet_id_idx'
gzip -dc "$DB_DIR/isucon8q-initial-dataset.sql.gz" | mysql --host "$DB_HOST" -u"$DB_USER" "$DB_DATABASE"
mysql --host "$DB_HOST" -u"$DB_USER" "$DB_DATABASE" -e 'ALTER TABLE reservations ADD KEY event_id_and_sheet_id_idx (event_id, sheet_id)'

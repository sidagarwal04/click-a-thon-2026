#!/usr/bin/env bash
# Load the dataset into a fresh ClickHouse Cloud service, into database $DB.
# Usage:
#   CH='clickhouse-client --host ... --user ... --password ... --secure' DB=clickathon ./load.sh
# DB defaults to 'default'; the database is created if it does not exist.
# (Use a simple identifier for DB, e.g. clickathon — no spaces/quotes.)
set -euo pipefail
CH="${CH:-clickhouse-client}"
DB="${DB:-default}"
DIR="$(cd "$(dirname "$0")" && pwd)"
$CH --query "CREATE DATABASE IF NOT EXISTS $DB"
$CH --database "$DB" --multiquery < "$DIR/ddl.sql"
$CH --database "$DB" --query "INSERT INTO destination_card_clicked FORMAT Parquet" < "$DIR/destination_card_clicked.parquet"
$CH --database "$DB" --query "INSERT INTO application_started FORMAT Parquet" < "$DIR/application_started.parquet"
$CH --database "$DB" --query "INSERT INTO document_uploaded FORMAT Parquet" < "$DIR/document_uploaded.parquet"
$CH --database "$DB" --query "INSERT INTO purchase_completed FORMAT Parquet" < "$DIR/purchase_completed.parquet"
$CH --database "$DB" --query "INSERT INTO search_typed FORMAT Parquet" < "$DIR/search_typed.parquet"
$CH --database "$DB" --query "INSERT INTO landing_page_scrolled FORMAT Parquet" < "$DIR/landing_page_scrolled.parquet"
$CH --database "$DB" --query "INSERT INTO auth_completed FORMAT Parquet" < "$DIR/auth_completed.parquet"
$CH --database "$DB" --query "INSERT INTO pay_now_clicked FORMAT Parquet" < "$DIR/pay_now_clicked.parquet"
echo "loaded into $DB"

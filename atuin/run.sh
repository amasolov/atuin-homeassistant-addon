#!/usr/bin/env bash

set -eu

command -v jq >/dev/null 2>&1 || { echo >&2 "jq is required but it's not installed. Aborting."; exit 1; }

# Read from options.json
DB_HOST=$(jq -r ".db_host" /data/options.json)
DB_PORT=$(jq -r ".db_port" /data/options.json)
DB_USER=$(jq -r ".db_user" /data/options.json)
DB_PASSWORD=$(jq -r ".db_password" /data/options.json)
DB_NAME=$(jq -r ".db_name" /data/options.json)



export DATABASE_URL="postgres://${DB_USER}:${DB_PASSWORD}@${DB_HOST}:${DB_PORT}/${DB_NAME}"
export ATUIN_OPEN_REGISTRATION=true

# Wait for PostgreSQL to be ready
echo "Waiting for PostgreSQL at ${DB_HOST}:${DB_PORT}..."
while ! nc -z ${DB_HOST} ${DB_PORT}; do
  sleep 1
done

# Start server
echo "Starting Atuin server..."
exec atuin server start --host 0.0.0.0 --port 8888


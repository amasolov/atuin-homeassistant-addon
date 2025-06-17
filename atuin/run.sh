#!/bin/sh

# Set database URL from configuration
export DATABASE_URL="postgres://${DB_USER}:${DB_PASSWORD}@${DB_HOST}:${DB_PORT}/${DB_NAME}"

# Wait for PostgreSQL to be ready
echo "Waiting for PostgreSQL at ${DB_HOST}:${DB_PORT}..."
while ! nc -z ${DB_HOST} ${DB_PORT}; do
  sleep 1
done

# Run migrations
echo "Running database migrations..."
./atuin-server migrate

# Start server
echo "Starting Atuin server..."
exec atuin-server start --host 0.0.0.0 --port 8888


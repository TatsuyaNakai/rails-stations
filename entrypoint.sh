#!/bin/bash
set -e

# Remove a potentially pre-existing server.pid for Rails.
rm -f /app/tmp/pids/server.pid

ruby -v

# Then exec the container's main process (what's set as CMD in the Dockerfile).
if [ "$CRON_MODE" = "true" ]; then
  bundle exec whenever --update-crontab
  exec cron -f
else
  # Execute the container's main process (CMD)
  exec "$@"
fi

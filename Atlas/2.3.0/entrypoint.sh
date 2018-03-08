#!/bin/sh

echo "Creating local config..."
envsubst < /config-local.js > /usr/share/nginx/html/js/config-local.js
echo "Config replacement completed with status $?"

echo "Starting nginx..."

exec nginx -g 'daemon off;'

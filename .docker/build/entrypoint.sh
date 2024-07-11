#!/bin/sh

php artisan migrate

# # Optimizing Configuration loading
php artisan config:cache
# # Optimizing Route loading
php artisan route:cache
# # Optimizing View loading
php artisan view:cache

rm -f .env.example
rm -rf .docker

chown -R www-data:www-data .

# printing the container IP
curl ipinfo.io.

# This will exec the CMD from your Dockerfile, i.e. "npm start"
exec "$@"

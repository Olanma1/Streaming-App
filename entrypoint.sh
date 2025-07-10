#!/bin/bash

# Create the DB file if it doesn't exist
if [ ! -f /var/data/database.sqlite ]; then
    echo "Creating SQLite database..."
    touch /var/data/database.sqlite
fi

# Ensure the DB file is writable by web server
chown www-data:www-data /var/data/database.sqlite
chmod 664 /var/data/database.sqlite

# Laravel cache setup
php artisan config:clear
php artisan route:clear
php artisan view:clear

php artisan config:cache
php artisan route:cache
php artisan view:cache

# Run migrations
php artisan migrate --force

# Start Apache
exec apache2-foreground

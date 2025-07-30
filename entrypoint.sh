#!/bin/bash

# Create the DB file if it doesn't exist
if [ ! -f /var/data/database.sqlite ]; then
    echo "Creating SQLite database..."
    touch /var/data/database.sqlite
fi

# Ensure the DB file is writable by web server
chown www-data:www-data /var/data/database.sqlite
chmod 664 /var/data/database.sqlite

# Laravel cache clear (initial)
php artisan config:clear
php artisan route:clear
php artisan view:clear

# Run migrations
php artisan migrate --force

# Laravel cache rebuild (post-migration)
php artisan config:cache
php artisan route:cache
php artisan view:cache

# Start Apache
exec apache2-foreground

#!/bin/bash

# Create SQLite DB file if it doesn't exist
if [ ! -f /var/data/database.sqlite ]; then
    echo "Creating SQLite database..."
    touch /var/data/database.sqlite
    chmod 775 /var/data/database.sqlite
    chown www-data:www-data /var/data/database.sqlite
fi

# Laravel cache setup
php artisan config:clear
php artisan route:clear
php artisan view:clear

php artisan config:cache
php artisan route:cache
php artisan view:cache

# Run migrations (safe even if no new migrations)
php artisan migrate --force

# Start Apache
apache2-foreground

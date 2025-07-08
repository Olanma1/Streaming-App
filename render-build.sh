#!/usr/bin/env bash
composer install --no-dev --optimize-autoloader
php artisan config:cache

# Use official PHP image with Apache
FROM php:8.2-apache

# Install system dependencies
RUN apt-get update && apt-get install -y \
    zip unzip curl git libonig-dev libxml2-dev libzip-dev sqlite3 libsqlite3-dev \
    && docker-php-ext-install pdo pdo_mysql pdo_sqlite zip

# Enable Apache mod_rewrite
RUN a2enmod rewrite

# Set working directory
WORKDIR /var/www

# Copy app files
COPY . /var/www

# Point Apache to Laravel's public directory
RUN rm -rf /var/www/html && ln -s /var/www/public /var/www/html

# Install Composer
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

# Install dependencies
RUN composer install --no-dev --optimize-autoloader

# Ensure the SQLite file exists for first deployment
RUN mkdir -p /var/data && touch /var/data/database.sqlite

# Permissions
RUN chown -R www-data:www-data /var/www \
 && chmod -R 775 storage bootstrap/cache

# Laravel optimization commands (after env is correctly set)
RUN php artisan config:clear \
 && php artisan config:cache \
 && php artisan route:cache \
 && php artisan view:cache

# DO NOT run migrate here if database may not exist yet — better done on deploy or via entrypoint

# Expose web port
EXPOSE 80

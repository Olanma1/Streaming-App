# Use PHP 8.2 + Apache
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
COPY . .

# Point Apache to public directory
RUN rm -rf /var/www/html && ln -s /var/www/public /var/www/html

# Install Composer
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

# Install Laravel dependencies
RUN composer install --optimize-autoloader --no-dev

# Ensure DB file exists
RUN mkdir -p /var/data && touch /var/data/database.sqlite

# Set permissions
RUN chown -R www-data:www-data /var/www \
 && chmod -R 775 storage bootstrap/cache /var/data/database.sqlite

# Clear and cache config/routes/views
RUN php artisan config:clear \
 && php artisan route:clear \
 && php artisan view:clear

# Re-cache them (AFTER .env is copied)
RUN php artisan config:cache \
 && php artisan route:cache \
 && php artisan view:cache

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]


# Expose port
EXPOSE 80

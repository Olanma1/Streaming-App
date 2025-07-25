# Use PHP 8.2 with Apache
FROM php:8.2-apache

# Install system dependencies
RUN apt-get update && apt-get install -y \
    zip unzip curl git libonig-dev libxml2-dev libzip-dev sqlite3 libsqlite3-dev gnupg \
    && docker-php-ext-install pdo pdo_mysql pdo_sqlite zip

# Install Node.js (16+ is required for Vite)
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash - \
    && apt-get install -y nodejs

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

# Install PHP dependencies
RUN composer install --optimize-autoloader --no-dev

# Install Node dependencies and build assets with Vite
RUN npm install && npm run build

# Make sure database file exists
RUN mkdir -p /var/data && touch /var/data/database.sqlite

# Set permissions
RUN chown -R www-data:www-data /var/www \
 && chmod -R 775 storage bootstrap/cache /var/data/database.sqlite

# Clear and cache Laravel
RUN php artisan config:clear \
 && php artisan route:clear \
 && php artisan view:clear \
 && php artisan config:cache \
 && php artisan route:cache \
 && php artisan view:cache

# Copy entrypoint script
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

# Expose port
EXPOSE 80

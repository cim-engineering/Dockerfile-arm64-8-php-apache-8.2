FROM php:8.2-apache

COPY . /app/

# system dependencies
RUN apt-get update && apt-get install -y \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libpng-dev \
    libzip-dev \
    && rm -rf /var/lib/apt/lists/*

#PHP extensions
RUN docker-php-ext-install mysqli pdo pdo_mysql zip

#Redis extension
RUN pecl install redis && docker-php-ext-enable redis

#Apache mod_rewrite
RUN a2enmod rewrite

# Change Apache document root to /app
RUN sed -i 's!/var/www/html!/app!g' /etc/apache2/sites-available/000-default.conf
RUN sed -i 's!/var/www/!/app!g' /etc/apache2/apache2.conf /etc/apache2/conf-available/*.conf

# Set the working directory
WORKDIR /app

# Update the Apache environment to point to the new document root
ENV APACHE_DOCUMENT_ROOT /app

#.htaccess configs 
RUN sed -i '/<Directory \/app>/,/<\/Directory>/ s/AllowOverride None/AllowOverride All/' /etc/apache2/apache2.conf
RUN sed -i 's/html/app/g' /etc/apache2/sites-available/000-default.conf

#disable PHP error handling
RUN echo "error_reporting = E_ALL & ~E_DEPRECATED & ~E_STRICT" > /usr/local/etc/php/conf.d/error-handling.ini \
    && echo "display_errors = Off" >> /usr/local/etc/php/conf.d/error-handling.ini \
    && echo "display_startup_errors = Off" >> /usr/local/etc/php/conf.d/error-handling.ini \
    && echo "log_errors = On" >> /usr/local/etc/php/conf.d/error-handling.ini \
    && echo "error_log = /dev/stderr" >> /usr/local/etc/php/conf.d/error-handling.ini \
    && echo "ignore_repeated_errors = On" >> /usr/local/etc/php/conf.d/error-handling.ini

# Expose port 80
EXPOSE 80
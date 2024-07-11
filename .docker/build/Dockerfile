FROM shinsenter/php:8.3-fpm-apache-alpine

# Set the document root of the apache config
ENV DOCUMENT_ROOT=/public

# Allow composer to be executed
ENV COMPOSER_ALLOW_SUPERUSER=1

# Installing required packages
RUN apk update
RUN apk add curl

# Install PHP Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Install NPM
RUN apk add npm

# copy the custom Apache config/vhosts to the docker image
COPY .docker/build/vhosts.apache.conf /etc/apache2/sites-enabled/apache-custom.conf
# Delete the default Apache config/vhosts
RUN rm -f /etc/apache2/sites-enabled/00-default.conf

# Copy the custom/additional php config
COPY .docker/build/php-ini-overrides.ini /usr/local/etc/php/php-ini-overrides.ini

# Copy the files to docker image
COPY . /var/www/html

# Set the default working directory
WORKDIR /var/www/html

# Create .env
RUN cp .env.example .env

# Set the owner of the files/directories
ADD --chown=www-data:www-data . /var/www/html

# Run composer
RUN composer install --no-interaction --optimize-autoloader --no-dev

# Install NPM packages
RUN npm install

# Build NPM packages
RUN npm run build

# Copy a custom entrypoint script to be executed when a container is launched
COPY .docker/build/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT [ "/entrypoint.sh", "docker-php-entrypoint" ]

FROM php:7.2-fpm as php-7-2-build

# Set some image labels
LABEL evilwizardcreations.image.authors="evil.wizard95@googlemail.com" \
    evilwizardcreations.image.php.version="7.2"

# copy the specific Composer PHAR version from the Composer image into the PHP image
COPY --from=composer:1.10.1 /usr/bin/composer /usr/bin/composer

# npm -v 6.4.1
# yarn -v 1.15.2

# Install some extra stuff
RUN set -ex; \
    apt-get update; \
    apt-get install -y --no-install-recommends \ 
      libxml2-dev \
      libzip-dev \
      libyaml-dev \
      zip \
      git \
      nodejs  \
      default-mysql-client \ 
      vim; \
    apt-get clean;

# Install some php extensions from the docker built source.
RUN docker-php-ext-install gettext mysqli pdo_mysql zip
RUN pecl install yaml && \
    docker-php-ext-enable yaml

WORKDIR /var/www
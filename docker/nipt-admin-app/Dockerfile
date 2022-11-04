# TODO: php ver8は must webサーバーは openlitespeedになるかも
FROM php:8.0.11-apache

RUN cd /etc/apache2/mods-enabled \
    && ln -s ../mods-available/rewrite.load

# php, apache 設定ファイル書き換え
ADD php.ini /usr/local/etc/php/
ADD 000-default.conf /etc/apache2/sites-enabled/

# laravel 構築
RUN cd /usr/bin && curl -s http://getcomposer.org/installer | php && ln -s /usr/bin/composer.phar /usr/bin/composer

RUN apt-get update \
    && apt-get install -y \
    git \
    zip \
    unzip \
    libzip-dev \
    vim \
    libpng-dev \
    libpq-dev \
    libfreetype6-dev \
    libjpeg-dev \
    libonig-dev

# PostgreSQL driver 構築
RUN set -ex apk --no-cache add postgresql-dev libpq-dev && \
    apt-get update && apt-get install -y \
    less \
    postgresql \
    && docker-php-ext-install bcmath pgsql pdo_pgsql

RUN docker-php-ext-configure gd \
    --with-freetype=/usr/include/ \
    --with-jpeg=/usr/include \
    && docker-php-ext-install -j$(nproc) gd

RUN pecl install xdebug \
    && docker-php-ext-enable xdebug

# Laravel
ENV COMPOSER_ALLOW_SUPERUSER 1
ENV COMPOSER_HOME /composer
ENV PATH $PATH:/composer/vendor/bin

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

RUN composer self-update --2

# node,npm
RUN curl -sL https://deb.nodesource.com/setup_16.x | bash -
RUN rm -rf node_modules
RUN apt-get install -y nodejs
RUN npm install npm -g n --save-dev cross-env
RUN npm cache clear --force
RUN npm install webpack --save
RUN npm install node-sass --nodedir=/usr/bin/node

# Laravel Dusk
ENV CHROME_VERSION "google-chrome-stable"
RUN sed -i -- 's&deb http://deb.debian.org/debian jessie-updates main&#deb http://deb.debian.org/debian jessie-updates main&g' /etc/apt/sources.list \
    && apt-get update && apt-get install wget -y
ENV CHROME_VERSION "google-chrome-stable"
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
    && echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list \
    && apt-get update && apt-get -qqy install ${CHROME_VERSION:-google-chrome-stable}
RUN docker-php-ext-install zip

# 作業ディレクトリ
WORKDIR /var/www/html

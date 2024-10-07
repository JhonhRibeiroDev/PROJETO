FROM ubuntu:focal

RUN apt-get update
RUN apt-get install software-properties-common -y
RUN add-apt-repository ppa:ondrej/php
RUN apt-get update

RUN apt install -y \
    apt-transport-https \
    ca-certificates \
    wget \
    curl \
    libzip-dev \
    unzip \
    apache2

RUN a2enmod rewrite

RUN apt-get install -y \
    php8.3 \
    php8.3-bcmath \
    php8.3-curl \
    php8.3-gd \
    php8.3-mcrypt \
    php8.3-mbstring \
    php8.3-mysql \
    php8.3-soap \
    php8.3-xml \
    php8.3-zip \
    composer

COPY ./docker/vhost.conf /etc/apache2/sites-enabled/000-default.conf
COPY ./public /var/www/html
RUN chown -R www-data:www-data /var/www/html && \
    chmod -R 755 /var/www/html
WORKDIR /var/www/html
EXPOSE 8000


CMD ["apache2ctl", "-D", "FOREGROUND"]
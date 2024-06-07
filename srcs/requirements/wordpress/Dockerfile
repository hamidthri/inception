FROM debian:bullseye

RUN apt-get update && apt-get install -y \
    php7.4-fpm \
    php7.4-mysql \
    curl \
    less \
    default-mysql-client \
    && rm -rf /var/lib/apt/lists/*

RUN curl -o /usr/local/bin/wp https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x /usr/local/bin/wp

WORKDIR /var/www/html

COPY ./conf/wp-config.php /var/www/html/wp-config.php
COPY ./tools/setup.sh /usr/local/bin/setup.sh
RUN chmod +x /usr/local/bin/setup.sh

RUN sed -i 's/listen = \/run\/php\/php7.4-fpm.sock/listen = 9000/g' /etc/php/7.4/fpm/pool.d/www.conf
RUN chown -R www-data:www-data /var/www/html \
    && chown -R www-data:www-data /var/log \
    && chown -R www-data:www-data /etc/php/7.4/fpm \
    && mkdir -p /run/php \
    && chown -R www-data:www-data /run/php/

EXPOSE 9000

CMD ["/usr/local/bin/setup.sh"]

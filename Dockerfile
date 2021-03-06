FROM jubicoy/nginx-php:latest
ENV PIWIK_VERSION 2.14.3

RUN apt-get update && apt-get install -y \
    php5-mysql php5-gd php5-ldap \
    gzip \
    libgcrypt11-dev zlib1g-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libgeoip-dev \
    libpng12-dev \
    zip \
    vim \
    && rm -rf /var/lib/apt/lists/*

RUN curl -k https://builds.piwik.org/piwik-${PIWIK_VERSION}.tar.gz | tar zx -C /workdir/

# Add configuration files
ADD config/default.conf /etc/nginx/conf.d/default.conf
ADD config/php.ini /etc/php5/fpm/php.ini
ADD config/config.ini.php /workdir/config/config.ini.php
ADD entrypoint.sh /workdir/entrypoint.sh

RUN chown -R 104:0 /var/www && chmod -R 777 /var/www && \
    chmod a+x /workdir/entrypoint.sh && chmod g+rw /workdir && \
    chmod -R 777 /workdir/ && \
    mkdir -p /var/www/piwik && chown -R 104:0 /var/www/piwik && chmod -R 777 /var/www/


EXPOSE 5000
USER 104

VOLUME ["/var/www/piwik"]

FROM jubicoy/nginx-php:latest
ENV PIWIK_VERSION latest

RUN apt-get update && apt-get install -y \
    php5-mysql php5-gd php5-ldap \
    gzip \
    libgcrypt11-dev zlib1g-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libgeoip-dev \
    libpng12-dev \
    zip \
    && rm -rf /var/lib/apt/lists/*

RUN curl -k https://builds.piwik.org/piwik-${PIWIK_VERSION}.tar.gz | tar zx -C /workdir/

# Add configuration files
ADD config/default.conf /etc/nginx/conf.d/default.conf
ADD config/php.ini /etc/php5/fpm/php.ini
ADD entrypoint.sh /workdir/entrypoint.sh

RUN mkdir -p /var/www/piwik/ \
    && chown 1000510000:0 /var/www/piwik/ \
    && chmod a+rwx /var/www/piwik/

EXPOSE 5000
USER 104

VOLUME ["/var/www/piwik"]

FROM php:8.3-cli

LABEL description="Laravel React SaaS - dev image"

# Dépendances système + extensions PHP
RUN apt-get update && apt-get install -y --no-install-recommends \
        curl \
        git \
        unzip \
        libpq-dev \
        libzip-dev \
        libonig-dev \
    && docker-php-ext-install pdo_pgsql pgsql zip mbstring \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Node.js 22 (pour npm + build Vite)
RUN curl -fsSL https://deb.nodesource.com/setup_22.x | bash - \
    && apt-get install -y --no-install-recommends nodejs \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Composer
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

WORKDIR /var/www/html

EXPOSE 8000

COPY docker/entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT ["entrypoint.sh"]

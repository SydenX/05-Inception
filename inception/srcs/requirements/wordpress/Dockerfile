FROM debian:bullseye

RUN apt update && \
    apt install --no-install-recommends wget curl gnupg2 ca-certificates apt-transport-https software-properties-common -y && \
    echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" | tee /etc/apt/sources.list.d/sury-php.list && \
    wget -qO - https://packages.sury.org/php/apt.gpg | apt-key add - && \
    apt-get update -y && \
    apt-get install --no-install-recommends php8.1 php8.1-fpm php8.1-mysqli mariadb-client -y

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp

RUN rm -rf /var/lib/apt/lists/* /tmp/*

COPY ./tools/www.conf /etc/php/8.1/fpm/pool.d/
COPY ./tools/init_wordpress.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/init_wordpress.sh && \
    mkdir -p /run/php

WORKDIR /var/www/html/

CMD ["/usr/local/bin/init_wordpress.sh"]


FROM debian:bullseye

RUN apt-get update -y && \
    apt-get upgrade -y && \
    apt-get install -y mariadb-server mariadb-client && \
    rm -rf /var/lib/apt/lists/* \
    && mkdir -p /run/mysqld \
    && touch /run/mysqld/mysqld.pid \
    && touch /run/mysqld/mysqld.sock \
    && chown -R mysql:mysql /run/mysqld \
    && chmod 777 /run/mysqld

COPY ./tools/50-server.cnf /etc/mysql/mariadb.conf.d/
RUN chmod 644 /etc/mysql/mariadb.conf.d/50-server.cnf && \
    chown mysql:mysql /etc/mysql/mariadb.conf.d/50-server.cnf

COPY ./tools/init_mariadb.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/init_mariadb.sh

EXPOSE 3306

ENTRYPOINT ["/usr/local/bin/init_mariadb.sh"]
CMD ["mysqld_safe", "--bind-address=0.0.0.0"]

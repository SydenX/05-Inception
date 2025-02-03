#!/bin/bash
echo "Starting MariaDB..."
mysql_install_db

/etc/init.d/mariadb start
echo "MariaDB started!"

if mariadb -uroot -p"$(cat ${MYSQL_ROOT_PASSWORD})" -p"$(cat ${MYSQL_ROOT_PASSWORD})" -h localhost -e "SHOW DATABASES;" | grep -q "${MYSQL_DATABASE}"; then
	echo "Database already exists"
else
	echo "Setting-up database..."
	mysql -uroot -p"$(cat ${MYSQL_ROOT_PASSWORD})" -h localhost -e "GRANT ALL ON *.* TO 'root'@'%' IDENTIFIED BY '$(cat ${MYSQL_ROOT_PASSWORD})';
	FLUSH PRIVILEGES;
	CREATE USER IF NOT EXISTS'${MYSQL_USER}'@'%' IDENTIFIED BY '$(cat ${MYSQL_PASSWORD})';
	CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};
	GRANT ALL ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%' IDENTIFIED BY '$(cat ${MYSQL_PASSWORD})';
	FLUSH PRIVILEGES;"

fi
echo "Stopping MariaDB."
#mysqladmin -uroot -p"$(cat ${MYSQL_ROOT_PASSWORD})" -h localhost shutdown
sleep 0.5
/etc/init.d/mariadb stop
echo "MariaDB stopped!"

exec "$@"

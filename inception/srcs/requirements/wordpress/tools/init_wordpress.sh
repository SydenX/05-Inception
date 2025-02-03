#!/bin/bash

for cmd in php curl; do
    if ! command -v "$cmd" &> /dev/null; then
        echo "$cmd not installed."
        exit 1
    fi
done


if ! command -v wp &> /dev/null; then
    echo "WP-CLI not found. Installing..."
    curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
    if [ $? -ne 0 ]; then
        echo "WP-CLI download failed."
        exit 1
    fi
    chmod +x wp-cli.phar
    mv wp-cli.phar /usr/local/bin/wp
else
    echo "WP-CLI is already installed."
fi

echo "Downloading WordPress..."
rm -r ./*
wp core download --path="." --allow-root

echo "Create WordPress database."
sleep 1
wp config create --dbname=${MYSQL_DATABASE} --dbuser=${MYSQL_USER} --dbpass=$(cat ${MYSQL_PASSWORD}) --dbhost=${MYSQL_HOST} --allow-root

echo "Installing WordPress..."
wp core install --url=${WP_URL} --title=${WP_TITLE} --admin_user=${WP_ADMIN_USER} --admin_password=$(cat ${WP_ADMIN_PASS}) --admin_email=${WP_ADMIN_MAIL} --allow-root --path="." --allow-root

echo "WordPress installation check."
wp core is-installed --path="." --allow-root

echo "Creating user Bob."
wp user create ${WP_BOB_USER} ${WP_BOB_MAIL} --role=author --allow-root
if [ $? -eq 0 ]; then
    wp user update ${WP_BOB_USER} --user_pass="$(cat ${WP_BOB_PASS})" --allow-root
fi

echo "WordPress successfully installed and configured !"

rm -f wp-cli.phar

echo "Starting PHP-FPM..."
php-fpm8.1 -F

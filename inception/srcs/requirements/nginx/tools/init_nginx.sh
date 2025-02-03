#!/bin/bash

if [ ! -f /etc/ssl/certs/jtollena.42.fr.cert.pem ]
then
	openssl req -x509 -newkey rsa:4096 -keyout /etc/ssl/certs/jtollena.42.fr.key.pem -out /etc/ssl/certs/jtollena.42.fr.cert.pem -sha256 -nodes -subj "/C=XX/ST=Belgium/L=Brussels/O=19/OU=Dev/CN=jtollena.42.fr"
fi

exec "$@"

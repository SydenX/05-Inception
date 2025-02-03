FROM debian:bullseye

RUN apt update && apt upgrade -y && apt install nginx openssl -y

COPY ./tools/default /etc/nginx/sites-available/.
COPY ./tools/init_nginx.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/init_nginx.sh
RUN mkdir -p /etc/ssl/certs/

ENTRYPOINT ["/usr/local/bin/init_nginx.sh"]
CMD ["nginx", "-g", "daemon off;"]

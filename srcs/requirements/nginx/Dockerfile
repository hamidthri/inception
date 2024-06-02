FROM debian:buster

WORKDIR /nginx

# OpenSSL supports various versions of the SSL and TLS protocols, including SSLv3, TLSv1.0, TLSv1.1, TLSv1.2, and TLSv1.3.
# These protocols are used to establish secure connections between clients and servers.
# Overall, OpenSSL plays a crucial role in securing internet communication, ensuring privacy, integrity, and authenticity in various online transactions and interactions.

RUN apt-get update && apt-get install -y nginx openssl

RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/nginx-selfsigned.key -out /etc/ssl/certs/nginx-selfsigned.crt -subj "/C=FR/ST=Paris/L=Paris/O=42/OU=42/CN=localhost"

COPY ./conf/default /etc/nginx/sites-available/default

RUN chmod +x /etc/nginx/sites-available/default

CMD ["nginx", "-g", "daemon off;"]

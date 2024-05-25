FROM debian:buster-slim

# Install nginx and ssl
RUN apt-get upgrade && apt-get update && apt-get install -y nginx openssl

# Copy the configuration file
COPY ./nginx.conf /etc/nginx/sites-available/default

COPY ./tools/script.sh /

CMD [ "script.sh" ]
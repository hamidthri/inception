FROM debian:buster-slim

RUN apt-get upgrade && apt-get update && apt-get install -y pphp-fpm php-mysql
RUN apt-get install -y curl

COPY ./tools/script.sh /

CMD [ "script.sh" ]
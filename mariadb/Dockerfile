FROM debian:buster-slim

RUN apt-get upgrade && apt-get update && apt-get install -y mariadb-server

COPY .script.sh .

CMD [ "script.sh" ]
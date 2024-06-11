# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: htaheri <htaheri@student.42.fr>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/05/26 15:10:50 by htaheri           #+#    #+#              #
#    Updated: 2024/06/11 19:20:58 by htaheri          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

DOCKER_COMPOSE = docker-compose -f srcs/docker-compose.yml
VOLUME_DIR = /home/htaheri/data

all: create_volume up

create_volume:
	@if [ ! -d ${VOLUME_DIR}/mariadb ]; then mkdir -p ${VOLUME_DIR}/mariadb; fi
	@if [ ! -d ${VOLUME_DIR}/wordpress ]; then mkdir -p ${VOLUME_DIR}/wordpress; fi


delete_volume:
	@if [ -d ${VOLUME_DIR}/mariadb ]; then rm -rf ${VOLUME_DIR}/mariadb; fi
	@if [ -d ${VOLUME_DIR}/wordpress ]; then rm -rf ${VOLUME_DIR}/wordpress; fi

build: create_volume
	${DOCKER_COMPOSE} build
up: build 
	${DOCKER_COMPOSE} up
	
down:
	${DOCKER_COMPOSE} down

stop:
	${DOCKER_COMPOSE} stop

start:
	${DOCKER_COMPOSE} start

clean: down
	docker container prune -f
	docker network prune -f
	docker image prune -f

fclean: clean delete_volume
	docker system prune -a -f

re: clean all

restart:
	${DOCKER_COMPOSE} restart

.PHONY: all create_volume delete_volume build up down stop start clean fclean re restart
# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: htaheri <htaheri@student.42.fr>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/05/26 15:10:50 by htaheri           #+#    #+#              #
#    Updated: 2024/06/09 19:03:04 by htaheri          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

DOCKER_COMPOSE = docker-compose -f srcs/docker-compose.yml
VOLUME_DIR = /Users/htaheri/Documents/projects/seventh/inception/volumes

all: build up

build:
	mkdir -p ${VOLUME_DIR}/mariadb
	mkdir -p ${VOLUME_DIR}/wordpress
	${DOCKER_COMPOSE} build
up:
	${DOCKER_COMPOSE} up
	
down:
	${DOCKER_COMPOSE} down

stop:
	${DOCKER_COMPOSE} stop

start:
	${DOCKER_COMPOSE} start

clean: down
	if [ -d ${VOLUME_DIR}/mariadb ]; then rm -rf ${VOLUME_DIR}/mariadb; fi
	if [ -d ${VOLUME_DIR}/wordpress ]; then rm -rf ${VOLUME_DIR}/wordpress; fi
	${DOCKER_COMPOSE} down --rmi all
	docker volume rm $$(docker volume ls -q)
	docker system prune -f --volumes

re: clean all

restart:
	${DOCKER_COMPOSE} restart

.PHONY: all build up down ps clean
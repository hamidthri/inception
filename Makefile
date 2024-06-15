# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: htaheri <htaheri@student.42.fr>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/05/26 15:10:50 by htaheri           #+#    #+#              #
#    Updated: 2024/06/15 16:27:36 by htaheri          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

DOCKER_COMPOSE = docker-compose -f srcs/docker-compose.yml
VOLUME_DIR = /Users/htaheri/Documents/GitHub/inception/volumes2

all: create_volume up

create_volume:
	@mkdir -p ${VOLUME_DIR}/mariadb ${VOLUME_DIR}/wordpress

delete_volume:
	${DOCKER_COMPOSE} down --volumes --remove-orphans

build: create_volume
	${DOCKER_COMPOSE} build

up: build 
	${DOCKER_COMPOSE} up

down:
	${DOCKER_COMPOSE} down

clean:
	docker container prune -f
	docker network prune -f
	docker image prune -f

fclean: clean delete_volume
	docker system prune -f -a
	docker system prune -a --volumes

re: clean all

.PHONY: all create_volume delete_volume build up down clean fclean re



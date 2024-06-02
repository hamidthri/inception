# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: htaheri <htaheri@student.42.fr>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/05/26 15:10:50 by htaheri           #+#    #+#              #
#    Updated: 2024/06/01 12:42:06 by htaheri          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #


all: up

up:
	docker-compose -f srcs/docker-compose.yml up -d --build
	
down:
	docker-compose -f srcs/docker-compose.yml down

stop:
	docker-compose -f srcs/docker-compose.yml stop

start:
	docker-compose -f srcs/docker-compose.yml start

ps:
	docker ps
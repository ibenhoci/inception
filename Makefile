NAME = inception

CONFIG_PATH = srcs/docker-compose.yml
ENV = srcs/.env

W_DATA = ~/data/wordpress
M_DATA = ~/data/mariadb

manage_data:
	@echo "MANAGING ${NAME} CONFIGURATION\n"
	@if [ ! -d "$W{_DATA}" ]; then \
		mkdir -p ${W_DATA};
	fi 
	@if [ ! -d "$(M_DATA)" ]; then \
		mkdir -p $(M_DATA); \
	fi

all: start
	@echo "LAUNCHING ${NAME}...\n"

build: manage_data
	@echo "Building config for ${NAME}...\n"
	@docker-compose -f srcs/docker-compose.yml --env-file srcs/.env build

run: build
	@echo "STARTING ${NAME} CONTAINERS\n"
	@docker-compose -f $(CONFIG_PATH) --env-file $(ENV) up -d

start:
	@echo "STARTING ${NAME} CONTAINERS\n"
	@docker-compose -f $(CONFIG_PATH) --env-file $(ENV) up -d

down:
	@echo "SHUTTING ${NAME} DOWN\n"
	@docker-compose -f $(CONFIG_PATH) --env-file $(ENV)  down


clean: down
	@echo "CLEANING ${NAME}\n"
	@docker-compose -f $(CONFIG_PATH) --env-file $(ENV) down --volumes --remove-orphans
	@sudo rm -rf $(W_DATA) && rm -rf $(M_DATA)

fclean:
	@echo "WHIPING ${NAME}\n"
	@docker-compose -f $(CONFIG_PATH) --env-file $(ENV) down --volumes --remove-orphans
	@docker system prune --all --force --volumes && docker network prune --force && docker volume prune --force
	@sudo rm -rf $(W_DATA) && rm -rf $(M_DATA)

re:  fclean run
	@echo "REBUILDING ${NAME} CONTAINERS\n"

.PHONY	: all build down re clean fclean start run manage_data
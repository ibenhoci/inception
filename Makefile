NAME = inception

CONFIG_PATH = srcs/docker-compose.yml
ENV = srcs/.env
SCRIPT_PATH=srcs/requirements/tools/script.sh
W_DATA=/root/data/wordpress
M_DATA=/root/data/mariadb

all: run
	@echo "LAUNCHING ${NAME}...\n"

manage_data:
	sh $(SCRIPT_PATH)

build: manage_data
	@echo "Building config for ${NAME}...\n"
	@docker-compose -f srcs/docker-compose.yml --env-file srcs/.env build

run: build
	@echo "STARTING ${NAME} CONTAINERS\n"
	@docker-compose -f $(CONFIG_PATH) --env-file $(ENV) up -d

start: manage_data
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
	@echo "REBUILDING ${NAME} CONTAINERS FINISHED\n"

.PHONY	: all build down re clean fclean start run manage_data

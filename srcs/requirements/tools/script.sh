#!/bin/sh

echo "MANAGING ${NAME} CONFIGURATION\n"
if [ ! -d  ~/data/wordpress ]; then \
	mkdir -p ~/data/wordpress; \
fi; \
if [ ! -d ~/data/mariadb ]; then \
	mkdir -p ~/data/mariadb; \
fi

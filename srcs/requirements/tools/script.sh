#!/bin/sh

echo "MANAGING ${NAME} CONFIGURATION\n"
if [ ! -d  /root/data/wordpress ]; then \
	mkdir -p root/data/wordpress; \
fi; \
if [ ! -d /root/data/mariadb ]; then \
	mkdir -p /root/data/mariadb; \
fi

NAME = inception
DC = docker compose
DC_FILE = srcs/docker-compose.yml

VOL_PATH = /home/jguelen/data
WP_VOL_PATH = $(VOL_PATH)/wordpress_files
MARIA_VOL_PATH = $(VOL_PATH)/database

all: pre up

pre:
	mkdir -p $(VOL_PATH) $(WP_VOL_PATH) $(MARIA_VOL_PATH)
	@line="127.0.0.1 jguelen.42.fr"; \
	if ! grep -qF "$$line" /etc/hosts; then \
		echo "\n$$line" | sudo tee -a /etc/hosts >/dev/null; \
	fi

up:
	@if [ -f "srcs/.env" ]; then \
		$(DC) -f $(DC_FILE) up; \
	else \
		echo "Error: a .env file is required"; \
	fi

stop:
	$(DC) -f $(DC_FILE) stop

down:
	$(DC) -f $(DC_FILE) down 

vdown:
	$(DC) -f $(DC_FILE) down -v

clean:
	$(DC) -f $(DC_FILE) down --rmi local

viclean:
	$(DC) -f $(DC_FILE) down -v --rmi local
	sudo rm -rf $(WP_VOL_PATH)/*
	sudo rm -rf $(MARIA_VOL_PATH)/*

vclean:
	$(DC) -f $(DC_FILE) down -v
	sudo rm -rf $(WP_VOL_PATH)/*
	sudo rm -rf $(MARIA_VOL_PATH)/*

fclean:
	$(DC) -f $(DC_FILE) down -v --rmi all
	sudo rm -rf $(WP_VOL_PATH)/*
	sudo rm -rf $(MARIA_VOL_PATH)/*

reup: down all

re: clean all

rei: iclean all

revi: viclean all

ref: fclean all

.PHONY: all up stop down vdown clean vclean viclean fclean reup rei revi re ref
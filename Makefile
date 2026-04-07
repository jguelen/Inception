NAME = inception
DC = docker compose
DC_FILE = srcs/docker-compose.yml

all: up

up:
	@if [ -f ".env" ]; then \
		$(DC) -f $(DC_FILE) up
	else \
		echo "Error: a .env file is required";
	fi
stop:
	$(DC) -f $(DC_FILE) stop

down:
	$(DC) -f $(DC_FILE) down 

clean:
	$(DC) -f $(DC_FILE) down --rmi local

fclean:
	$(DC) -f $(DC_FILE) down -v --rmi all

reup: down all

re: clean all

ref: fclean all

.PHONY all up stop down clean fclean re ref reup
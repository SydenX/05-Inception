COMPOSE_DIR=srcs

nocache:
	docker compose -f $(COMPOSE_DIR)/docker-compose.yml build --no-cache
	$(MAKE) up
	
build:
	docker compose -f $(COMPOSE_DIR)/docker-compose.yml build 

detach:
	$(MAKE) build
	docker compose -f $(COMPOSE_DIR)/docker-compose.yml up -d

up:
	docker compose -f $(COMPOSE_DIR)/docker-compose.yml up

up-detach:
	docker compose -f $(COMPOSE_DIR)/docker-compose.yml up

down:
	docker compose -f $(COMPOSE_DIR)/docker-compose.yml down

rebuild: 
	$(MAKE) build 
	$(MAKE) up

logs:
	docker compose -f $(COMPOSE_DIR)/docker-compose.yml logs -f

clean:
	@docker stop $$(docker ps -qa);\
	docker system prune -a -f;\
	rm -rf /home/jtollena/data/wordpress/*;\
	rm -rf /home/jtollena/data/mariadb/*;

ps:	
	docker compose -f $(COMPOSE_DIR)/docker-compose.yml ps

help:
	@echo "	---= HELP =---	"
	@echo "nocache 	- Build and up from zero."
	@echo "rebuild 	- Build and up from cache."
	@echo "build 		- Build from cache."
	@echo "up 		- Run the containers."
	@echo "up-detach 	- Run the containers in detached mode."
	@echo "clean 		- Remove all containers, volumes and files related to."
	@echo "ps 		- List running containers."
	@echo ""


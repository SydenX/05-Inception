COMPOSE_DIR=srcs

build:
	docker compose -f $(COMPOSE_DIR)/docker-compose.yml build 

up:
	docker compose -f $(COMPOSE_DIR)/docker-compose.yml up

down:
	docker compose -f $(COMPOSE_DIR)/docker-compose.yml down

rebuild:
	docker compose -f $(COMPOSE_DIR)/docker-compose.yml build
	docker compose -f $(COMPOSE_DIR)/docker-compose.yml up
	
nocache:
	docker compose -f $(COMPOSE_DIR)/docker-compose.yml build --no-cache
	docker compose -f $(COMPOSE_DIR)/docker-compose.yml up


logs:
	docker compose -f $(COMPOSE_DIR)/docker-compose.yml logs -f

clean:
	@docker stop $$(docker ps -qa);\
	docker rm $$(docker ps -qa);\
	docker rmi -f $$(docker images -qa);\
	docker volume rm $$(docker volume ls -q);

ps:	
	docker compose -f $(COMPOSE_DIR)/docker-compose.yml ps

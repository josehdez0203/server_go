include .env	

# DSN=${USER}@tcp(localhost:3306)/widgets?parseTime=true&tls=false
# docker run --name ${APP} --network ${RED} -p ${PUERTO}:${PUERTO} -e POSTGRES_USER=${USER} -e POSTGRES_PASSWORD=${PASSWORD} -d ${VERSION}

db-on:
	@echo "Iniciando BD"
	docker-compose up -d	

db-off:
	@echo "Iniciando BD"
	docker-compose down --remove-orphans

createdb:
	@echo "Iniciando BD ${DB}"
	docker exec -it ${APP_NAME} createdb --username=${DB_USER} ${APP_DB}


dropdb:
	@echo "Eliminando BD ${DB}"
	docker exec -it ${APP_NAME} dropdb --username=${DB_USER} ${APP_DB}

migrate-up:
	migrate -path ./internal/adapters/postgres/migrations -database "postgres://${DB_USER}:${DB_PASSWORD}@${DB_SERVER}:${DB_PUERTO}/${APP_DB}?sslmode=disable" -verbose up

migrate-down:
	migrate -path ./internal/adapters/postgres/migrations -database "postgres://${DB_USER}:${DB_PASSWORD}@${DB_SERVER}:${DB_PUERTO}/${APP_DB}?sslmode=disable" -verbose down

migrate-up1:
	migrate -path ./internal/adapters/postgres/migrations -database "postgres://${DB_USER}:${DB_PASSWORD}@${DB_SERVER}:${DB_PUERTO}/${APP_DB}?sslmode=disable" -verbose up 1

migrate-down1:
	migrate -path ./internal/adapters/postgres/migrations -database "postgres://${DB_USER}:${DB_PASSWORD}@${DB_SERVER}:${DB_PUERTO}/${APP_DB}?sslmode=disable" -verbose down 1

sqlc:
	sqlc generate

net-create:
	@echo "Creando red ${APP_NET}"
	docker network create ${APP_NET}

net-drop:
	@echo "Eliminado red ${APP_NET}"
	docker network rm ${APP_NET}

init_db: dropdb createdb migrate-up
	@echo "Reiniciada la BD ${APP_DB}"


.PHONY: db-on db-off createdb dropdb migrate-up migrate-down migrate-up1 migrate-down1 sqlc net-create net-drop

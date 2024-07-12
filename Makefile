postgres:
	docker run --name pg_jhc --network red-jhc -p 5432:5432 -e POSTGRES_USER=root -e POSTGRES_PASSWORD=1234 -d postgres
	
createdb:
	docker exec -it pg_jhc createdb --username=root realstate

dropdb:
	docker exec -it pg_jhc dropdb --username=root realstate

migrate-up:
	migrate -path db/migrations -database "postgres://root:1234@localhost:5432/realstate?sslmode=disable" -verbose up

migrate-down:
	migrate -path db/migrations -database "postgres://root:1234@localhost:5432/realstate?sslmode=disable" -verbose down

migrate-up1:
	migrate -path db/migrations -database "postgres://root:1234@localhost:5432/realstate?sslmode=disable" -verbose up 1

migrate-down1:
	migrate -path db/migrations -database "postgres://root:1234@localhost:5432/realstate?sslmode=disable" -verbose down 1

sqlc:
	sqlc generate

test:
	go test -v -cover ./...

server:
	go run main.go

.PHONY: postgres createdb dropdb migrate-up migrate-down migrate-up1 migrate-down1 sqlc test server

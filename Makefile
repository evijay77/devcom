postgres:
	sudo docker run --name devcomdb -p 5432:5432 -e POSTGRES_USER=postgres -e POSTGRES_PASSWORD=postgres -d postgres:12-alpine

createdb:
	sudo docker exec -it devcomdb createdb --username=postgres --owner=postgres simple_bank

dropdb:
	sudo docker exec -it postgres12 dropdb simple_bank

schema:
	./lib/migrate create -ext sql -dir ../db/migration -seq init_schema

migrateup:
	./lib/migrate -path db/migration -database "postgresql://postgres:postgres@localhost:5432/simple_bank?sslmode=disable" -verbose up

migratedown:
	./lib/migrate -path db/migration -database "postgresql://postgres:postgres@localhost:5432/simple_bank?sslmode=disable" -verbose down

sqlc:
	sqlc generate

test:
	go test -v -cover ./...
	
server:
	go run main.go
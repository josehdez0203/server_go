package main

import (
	"database/sql"
	"log"
	"realstate/api"
	"realstate/util"

	db "realstate/db/sqlc"

	_ "github.com/lib/pq"
)

func main() {
	config, err := util.LoadConfig(".")
	if err != nil {
		log.Fatal("No se puede cargar la configuración: ", err)
	}
	conn, err := sql.Open(config.DBDriver, config.DBSource)
	if err != nil {
		log.Fatal("No se puede conectar a la DB", err)
	}

	store := db.NewStore(conn)
	server, err := api.NewServer(config, store)
	if err != nil {
		log.Fatal("No se puede crear el servidor", err)
	}

	err = server.Start(config.ServerAddress)
	if err != nil {
		log.Fatal("No puede iniciar el servidor: ", err)
	}
}

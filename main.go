package main

import (
	"context"
	"database/sql"
	"fmt"
	"log"

	_ "embed"

	_ "modernc.org/sqlite"

	"experiments/go-htmx-umejug/umejug"
)

//go:generate go run github.com/sqlc-dev/sqlc/cmd/sqlc@latest generate

//go:embed schema.sql
var schema string

func run(ctx context.Context) error {
	// Open an sqlite database in memory
	db, err := sql.Open("sqlite", ":memory:")
	if err != nil {
		return err
	}

	// Create the tables declared in the schema
	if _, err := db.ExecContext(ctx, schema); err != nil {
		return err
	}

	queries := umejug.New(db)

	ed, err := queries.CreateExchangeDay(ctx, umejug.CreateExchangeDayParams{
		Name:        "Peter",
		Swishnumber: "0123456789",
	})
	if err != nil {
		return err
	}

	ed, err = queries.UpdateExchangeDay(ctx, umejug.UpdateExchangeDayParams{
		ID:          ed.ID,
		Name:        "Adam",
		Swishnumber: "9876543210",
	})
	if err != nil {
		return err
	}

	seller, err := queries.CreateSeller(ctx, umejug.CreateSellerParams{
		Name:          "Säljaren",
		Swishnumber:   "4422115566",
		ExchangeDayID: ed.ID,
	})
	if err != nil {
		return err
	}

	fmt.Printf("%#v\n", seller)

	return nil
}

func main() {
	if err := run(context.Background()); err != nil {
		log.Fatal(err)
	}
}

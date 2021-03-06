package handlers

import (
	"github.com/labstack/echo/v4"
	"log"
)

//TODO: Use ctx.Bind() to types.Query

//Function to get user by his UserID
func (h *handler) User(ctx echo.Context) error {
	id := ctx.Param("id")

	row := h.Storage.QueryRow("SELECT * FROM test.user_get($1)", id)

	var data []byte
	err := row.Scan(&data)

	if err != nil {
		log.Printf("Failed to scan row: %v", err)
		return err
	}

	return ctx.JSONBlob(200, data)

}

//Function to get user's comment by comment ID and UserID
func (h *handler) UserComment(ctx echo.Context) error {
	//TODO: implement this

	return nil

}

func (h *handler) Comment(ctx echo.Context) error {
	cid := ctx.Param("cid")

	row := h.Storage.QueryRow("SELECT * FROM test.comments_get($1)", cid)

	var data []byte
	err := row.Scan(&data)

	if err != nil {
		log.Printf("Failed to scan row: %v", err)
		return err
	}

	return ctx.JSONBlob(200, data)

}

package handlers

import (
	"database/sql"
	"github.com/labstack/echo/v4"
)

type handler struct {
	Router  *echo.Echo
	Storage *sql.DB
}

func New(e *echo.Echo, s *sql.DB) *handler {
	return &handler{Router: e, Storage: s}
}

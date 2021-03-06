package main

import (
	"fmt"
	"github.com/labstack/echo/v4"
	"github.com/pressly/goose"
	"gopkg.in/yaml.v2"
	"io/ioutil"
	"log"
	"wbru/handlers"
	"wbru/storage"
	"wbru/types"
)

var config types.Config

//Init config variable from config file
func init() {
	c, err := ioutil.ReadFile("config.yaml")

	if err != nil {
		log.Fatalf("Failed to read config file: %v", err)
	}

	err = yaml.Unmarshal(c, &config)

	if err != nil {
		log.Fatalf("Failed to unmarshal config file: %v", err)
	}

}

func main() {
	e := echo.New()
	s, err := storage.New("host=localhost port=5432 user=admin password=admin dbname=postgres sslmode=disable")

	if err != nil {
		log.Fatalf("Failed to create storage: %v", err)
	}

	h := handlers.New(e, s)

	err = goose.Up(h.Storage, "migrate")

	if err != nil {
		log.Printf("Failed to migrate: %v", err)
	}

	endpoint := h.Router.Group(fmt.Sprintf("/%s/", config.Endpoint) + ":version")

	//Get user info by his id
	endpoint.GET("/user/:id", h.User)

	////Get user's comments
	//endpoint.GET("/user/:id/comment/", h.Comments)

	//Get comment by his id
	endpoint.GET("/comment/:cid", h.Comment)

	//Get comment by his id and user's id
	endpoint.GET("/user/:id/comment/:cid", h.UserComment)

	err = h.Router.Start(
		fmt.Sprintf("%s:%d", config.Host, config.Port),
	)

	if err != nil {
		log.Fatalf("Failed to start echo: %v", err)
	}

}

package main

import (
	"net/http"
)

func main() {
	logger := GetLogger()

	setupRoutes()

	logger.Log("info", "Go Web App Started on Port 3000")
	err := http.ListenAndServe(":3000", nil)
	if err != nil {
		logger.Log("error", err)
	}

}

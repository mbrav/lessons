package main

import (
	"fmt"
	"io"
	"net/http"
)

func getApiCall() string {
	logger.Log("info", "Calling Api")
	response, err := http.Get("http://pokeapi.co/api/v2/pokedex/kanto/")

	if err != nil {
		logger.Log(err)
	}

	responseData, err := io.ReadAll(response.Body)
	if err != nil {
		logger.Log(err)
	}

	// // Convert JSON response to a readable string
	// var result map[string]interface{}
	// if err := json.Unmarshal(responseData, &result); err != nil {
	// 	logger.Log(err)
	// }
	//
	// // Convert the map to a string representation
	// responseString := fmt.Sprintf("%v", result)
	// return responseString

	return string(responseData)
}

func homePage(w http.ResponseWriter, r *http.Request) {
	logger.Log("info", "Serving homepage")
	fmt.Fprintf(w, `{"msg": "hello"}`)
}

func health(w http.ResponseWriter, r *http.Request) {
	logger.Log("info", "Serving health")
	fmt.Fprintf(w, `{"status": "healthy"}`)
}

func getApi(w http.ResponseWriter, r *http.Request) {
	logger.Log("info", "Serving api")
	response := getApiCall()
	fmt.Fprintf(w, response)
	logger.Log("info", "Serving api don")
}

func setupRoutes() {
	logger.Log("info", "Setting up routes")

	http.HandleFunc("/", homePage)
	http.HandleFunc("/get", getApi)
	http.HandleFunc("/health", health)
}

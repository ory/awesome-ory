// Copyright © 2026 Ory Corp
// SPDX-License-Identifier: Apache-2.0

package main

import (
	"encoding/json"
	"log"
	"net/http"
)

type Response struct {
	Message string `json:"message"`
}

func helloJSON(w http.ResponseWriter, r *http.Request) {
	response := Response{Message: "Hello microservice"}
	w.Header().Set("Content-type", "application/json")
	w.WriteHeader(http.StatusOK)
	json.NewEncoder(w).Encode(response)
}
func main() {
	http.HandleFunc("/hello", helloJSON)
	log.Fatal(http.ListenAndServe(":8090", nil))

}

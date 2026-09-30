// Copyright © 2026 Ory Corp
// SPDX-License-Identifier: Apache-2.0

// Package main is the upstream "protected" service used by the Ory Oathkeeper
// examples. It echoes back the request headers it received, which is how each
// example demonstrates what its mutator actually injected.
package main

import (
	"encoding/json"
	"log"
	"net/http"
	"os"
)

type response struct {
	Message string      `json:"message"`
	Path    string      `json:"path"`
	Headers http.Header `json:"headers"`
}

func handle(w http.ResponseWriter, r *http.Request) {
	// Also log the headers, so the "read the container logs" narrative in the
	// example READMEs still works.
	if err := json.NewEncoder(os.Stdout).Encode(r.Header); err != nil {
		log.Printf("could not log headers: %s", err)
	}

	w.Header().Set("Content-Type", "application/json")
	if err := json.NewEncoder(w).Encode(response{
		Message: "Hello 👋",
		Path:    r.URL.Path,
		Headers: r.Header,
	}); err != nil {
		log.Printf("could not write response: %s", err)
	}
}

func main() {
	// Registered on "/" so that any path the access rules match reaches this
	// handler, not the mux's 404.
	http.HandleFunc("/", handle)
	log.Fatal(http.ListenAndServe(":8090", nil))
}

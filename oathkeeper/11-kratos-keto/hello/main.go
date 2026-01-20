// Copyright © 2026 Ory Corp
// SPDX-License-Identifier: Apache-2.0

package main

import (
	"bytes"
	"encoding/json"
	"fmt"
	"log"
	"net/http"

	"github.com/davecgh/go-spew/spew"
)

func handleHello(w http.ResponseWriter, r *http.Request) {
	spew.Dump(r.Header)

	fmt.Fprintln(w, "Hello 👋")
}

func writeError(w http.ResponseWriter, err string) {
	w.WriteHeader(http.StatusInternalServerError)
	w.Write([]byte(err))
}

func handleGrantAccess(w http.ResponseWriter, r *http.Request) {
	spew.Dump(r.Header)

	userID := r.Header.Get("X-User")
	if userID == "" {
		writeError(w, "no user id")
		return
	}
	rt, err := json.Marshal(map[string]string{
		"namespace":  "services",
		"object":     "hello-world-service",
		"relation":   "access",
		"subject_id": userID,
	})
	if err != nil {
		writeError(w, err.Error())
		return
	}

	req, err := http.NewRequest(http.MethodPut, "http://keto:4467/relation-tuples", bytes.NewReader(rt))
	if err != nil {
		writeError(w, err.Error())
		return
	}
	req.Header.Set("Content-Type", "application/json")
	resp, err := http.DefaultClient.Do(req)
	if err != nil {
		writeError(w, err.Error())
		return
	}
	resp.Body.Close()
	if resp.StatusCode != http.StatusCreated {
		writeError(w, fmt.Sprintf("unexpected status code: %d", resp.StatusCode))
		return
	}
	fmt.Fprintf(w, "Granted permission for user %q", userID)
}

func main() {
	http.HandleFunc("/hello", handleHello)
	http.HandleFunc("/grant-access", handleGrantAccess)
	log.Fatal(http.ListenAndServe(":8090", nil))
}

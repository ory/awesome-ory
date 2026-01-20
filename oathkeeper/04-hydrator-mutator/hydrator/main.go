// Copyright © 2026 Ory Corp
// SPDX-License-Identifier: Apache-2.0

package main

import (
	"encoding/json"
	"io"
	"log"
	"net/http"
	"net/url"
)

type AuthenticationSession struct {
	Subject      string                 `json:"subject"`
	Extra        map[string]interface{} `json:"extra"`
	Header       http.Header            `json:"header"`
	MatchContext MatchContext           `json:"match_context"`
}
type MatchContext struct {
	RegexpCaptureGroups []string    `json:"regexp_capture_groups"`
	URL                 *url.URL    `json:"url"`
	Method              string      `json:"method"`
	Header              http.Header `json:"header"`
}

func mutate(w http.ResponseWriter, r *http.Request) {
	payload := &AuthenticationSession{}
	data, err := io.ReadAll(r.Body)
	if err != nil {
		return
	}
	if err := json.Unmarshal(data, payload); err != nil {
		return
	}
	if payload.Header == nil {
		payload.Header = make(map[string][]string)
	}
	payload.Header.Add("x-user-name", "Andrew")
	payload.Header.Add("x-user-company", "Ory")
	payload.Header.Add("x-user-role", "admin")
	w.WriteHeader(http.StatusOK)
	json.NewEncoder(w).Encode(payload)
}

func main() {
	http.HandleFunc("/hydrate", mutate)
	log.Fatal(http.ListenAndServe(":8090", nil))
}

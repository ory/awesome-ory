// Copyright © 2026 Ory Corp
// SPDX-License-Identifier: Apache-2.0

package main

import (
	"fmt"
	"log"
	"net/http"

	"github.com/davecgh/go-spew/spew"
)

func handle(w http.ResponseWriter, r *http.Request) {
	spew.Dump(r.Header)
	fmt.Fprintf(w, "Hello 👋")
}

func main() {
	http.HandleFunc("/hello", handle)
	log.Fatal(http.ListenAndServe(":8090", nil))
}

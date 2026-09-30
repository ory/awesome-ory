#!/usr/bin/env bash
# Copyright © 2026 Ory Corp
# SPDX-License-Identifier: Apache-2.0

# Session replay alone misses browser redirects to Docker-only hostnames.
set -Eeuo pipefail

docker run --rm -i --network "$NETWORK" --entrypoint bash "$RUNNER_IMAGE" <<'SH'
set -Eeuo pipefail
for pair in Login:login Signup:registration; do
    action="${pair%%:*}"
    flow="${pair#*:}"
    headers="$(mktemp)"
    status="$(curl -sS --max-time 20 -o /dev/null -D "$headers" -w '%{http_code}' \
        -H 'Host: 127.0.0.1:5286' "http://app:5286/Home/$action")"
    location="$(awk 'tolower($1) == "location:" { print $2 }' "$headers" | tr -d '\r')"
    expected="http://127.0.0.1:4433/self-service/$flow/browser"
    if [ "$status" != 302 ] || [ "$location" != "$expected" ]; then
        echo "$action: expected 302 to $expected; got $status to $location" >&2
        exit 1
    fi
    rm -f "$headers"
    echo "  ok   $action redirects to the browser-facing Kratos API"
done
SH

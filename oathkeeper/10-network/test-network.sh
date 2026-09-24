#!/usr/bin/env bash
# Copyright © 2026 Ory Corp
# SPDX-License-Identifier: Apache-2.0
#
# The Ory Network lane for this example. Unlike the self-hosted examples this
# one needs a real project, because what it demonstrates is Oathkeeper checking
# sessions through the Ory tunnel.
#
#   ORY_PROJECT_ID=... ORY_PROJECT_API_KEY=... make test-network
#
# The project needs http://localhost:4000/ in its allowed return URLs:
#
#   ory patch identity-config --project "$ORY_PROJECT_ID" \
#     --replace '/selfservice/allowed_return_urls=["http://localhost:4000/"]'
#
# Requires: the Ory CLI, docker, curl, jq.

set -Eeuo pipefail

: "${ORY_PROJECT_ID:=${ORY_NETWORK_PROJECT_ID:-}}"
: "${ORY_PROJECT_API_KEY:=${ORY_NETWORK_PROJECT_API_KEY:-}}"

if [ -z "$ORY_PROJECT_ID" ]; then
	echo "skip: ORY_PROJECT_ID is not set"
	exit 0
fi
command -v ory >/dev/null || {
	echo "skip: the Ory CLI is not installed"
	exit 0
}

TUNNEL_PORT=4000
TUNNEL_URL="http://localhost:$TUNNEL_PORT"
JAR="$(mktemp)"
FAILURES=0

pass() { printf '  \033[32mok\033[0m   %s\n' "$*"; }
fail() {
	printf '  \033[31mFAIL\033[0m %s\n' "$*"
	FAILURES=$((FAILURES + 1))
}
assert_eq() {
	if [ "$2" = "$3" ]; then pass "$1 = $3"; else fail "$1: want '$2', got '$3'"; fi
}

cleanup() {
	local code=$?
	[ -n "${TUNNEL_PID:-}" ] && kill "$TUNNEL_PID" 2>/dev/null || true
	docker compose down -v --remove-orphans >/dev/null 2>&1 || true
	rm -f "$JAR"
	exit "$code"
}
trap cleanup EXIT

echo "== 10-network =="
docker compose up -d --build --quiet-pull

# `set +x` guards nothing here, but keep the key out of the process list by
# passing it through the environment rather than as an argument.
ORY_PROJECT_API_KEY="$ORY_PROJECT_API_KEY" \
	ory tunnel --project "$ORY_PROJECT_ID" --quiet "$TUNNEL_URL" --port "$TUNNEL_PORT" &
TUNNEL_PID=$!

deadline=$((SECONDS + 90))
until curl -sS -o /dev/null "$TUNNEL_URL/.ory/sessions/whoami" 2>/dev/null; do
	[ "$SECONDS" -lt "$deadline" ] || {
		echo "timed out waiting for the Ory tunnel" >&2
		exit 1
	}
	sleep 2
done

ENTRY="http://127.0.0.1:8080/hello"

assert_eq "anonymous status" "401" "$(curl -sS -o /dev/null -w '%{http_code}' "$ENTRY")"

# Same trick as the self-hosted examples: drive the browser-typed registration
# flow with Accept: application/json and read the session cookie out of the jar.
flow="$(curl -sS -c "$JAR" -H 'Accept: application/json' \
	"$TUNNEL_URL/self-service/registration/browser")"
flow_id="$(printf '%s' "$flow" | jq -r '.id')"
csrf="$(printf '%s' "$flow" |
	jq -r '.ui.nodes[] | select(.attributes.name == "csrf_token") | .attributes.value')"
email="smoke-$RANDOM-$RANDOM@example.com"

curl -sS -b "$JAR" -c "$JAR" \
	-H 'Accept: application/json' -H 'Content-Type: application/json' \
	-X POST "$TUNNEL_URL/self-service/registration?flow=$flow_id" \
	-d "$(jq -nc --arg c "$csrf" --arg e "$email" --arg p "Ory-Smoke-Test-$RANDOM-Pw!" \
		'{method: "password", csrf_token: $c, "traits.email": $e, password: $p}')" \
	>/dev/null

session="$(awk '$6 == "ory_kratos_session" { print $7 }' "$JAR" | tail -n1)"
[ -n "$session" ] || {
	echo "could not mint a session against the project" >&2
	exit 1
}

assert_eq "authenticated status" "200" \
	"$(curl -sS -o /dev/null -w '%{http_code}' -H "Cookie: ory_kratos_session=$session" "$ENTRY")"

body="$(curl -sS -H "Cookie: ory_kratos_session=$session" "$ENTRY")"
for pair in "X-User-Name=Andrew" "X-User-Company=Ory" "X-User-Role=admin"; do
	got="$(printf '%s' "$body" | jq -r --arg h "${pair%%=*}" '.headers[$h][0] // "<absent>"')"
	assert_eq "upstream header ${pair%%=*}" "${pair#*=}" "$got"
done

echo "note: this run registered '$email' in project $ORY_PROJECT_ID"

[ "$FAILURES" -eq 0 ] || exit 1
echo "== 10-network: all assertions passed =="

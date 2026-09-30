#!/usr/bin/env bash
# Copyright © 2026 Ory Corp
# SPDX-License-Identifier: Apache-2.0
#
# The Ory Network lane for this example. Unlike the self-hosted examples this one
# needs a real project, because what it demonstrates is Oathkeeper checking
# sessions through the Ory tunnel.
#
#   ORY_PROJECT_ID=... ORY_PROJECT_API_KEY=... make test-network
#
# The project needs http://localhost:4000/ among its allowed return URLs:
#
#   ory patch identity-config --project "$ORY_PROJECT_ID" \
#     --add '/selfservice/allowed_return_urls/-="http://localhost:4000/"'
#
# Like the self-hosted lane, the stack is started with its published ports
# stripped and the assertions run on its own Docker network, so a run does not
# compete for a port on the host. The tunnel is the exception: it runs on the
# host on :4000, which is where Oathkeeper's check_session_url points via
# host.docker.internal, and where the session is minted.
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

EXAMPLE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
COMMON_DIR="$(cd "$EXAMPLE_DIR/../../_common" && pwd)"
PROJECT=smoke-10-network
RUNNER_IMAGE="awesome-ory/smoke-runner"
OVERRIDE="$(mktemp -t smoke-override-XXXXXX).yml"
TUNNEL_PORT="${TUNNEL_PORT:-4000}"
TUNNEL_URL="http://localhost:$TUNNEL_PORT"
JAR="$(mktemp)"
TUNNEL_LOG="$(mktemp)"

compose() {
	docker compose -p "$PROJECT" -f "$EXAMPLE_DIR/docker-compose.yml" -f "$OVERRIDE" "$@"
}

cleanup() {
	local code=$?
	[ -n "${TUNNEL_PID:-}" ] && kill "$TUNNEL_PID" 2>/dev/null || true
	compose down -v --remove-orphans >/dev/null 2>&1 || true
	rm -f "$JAR" "$OVERRIDE" "$TUNNEL_LOG"
	exit "$code"
}
trap cleanup EXIT

printf '\033[1m== 10-network (Ory Network) ==\033[0m\n'

docker compose -f "$EXAMPLE_DIR/docker-compose.yml" config --format json |
	jq -r '"services:", (.services | keys[] | "  \(.):\n    ports: !override []")' \
		>"$OVERRIDE"

docker build -q -t "$RUNNER_IMAGE" "$COMMON_DIR/smoke" >/dev/null
compose up -d --build --quiet-pull

# The API key goes through the environment, never the command line, so it does
# not show up in the process list.
ORY_PROJECT_API_KEY="$ORY_PROJECT_API_KEY" \
	ory tunnel --quiet "$TUNNEL_URL" --port "$TUNNEL_PORT" >"$TUNNEL_LOG" 2>&1 &
TUNNEL_PID=$!

# The tunnel mirrors Ory's APIs at the root — note there is no /.ory prefix,
# which is an `ory proxy` convention, not a tunnel one.
deadline=$((SECONDS + 120))
until curl -sS -o /dev/null --max-time 5 "$TUNNEL_URL/sessions/whoami" 2>/dev/null; do
	[ "$SECONDS" -lt "$deadline" ] || {
		echo "timed out waiting for the Ory tunnel on $TUNNEL_URL" >&2
		sed -n '1,20p' "$TUNNEL_LOG" >&2
		exit 1
	}
	sleep 2
done

# Same trick as the self-hosted lane: drive the browser-typed registration flow
# with Accept: application/json and read the cookie out of the jar. Registration
# issues a session because the project has the `session` hook after password.
EMAIL="smoke-$RANDOM-$RANDOM@example.com"
flow="$(curl -sS -c "$JAR" -H 'Accept: application/json' \
	"$TUNNEL_URL/self-service/registration/browser")"
flow_id="$(printf '%s' "$flow" | jq -r '.id')"
csrf="$(printf '%s' "$flow" |
	jq -r '.ui.nodes[] | select(.attributes.name == "csrf_token") | .attributes.value')"

curl -sS -b "$JAR" -c "$JAR" \
	-H 'Accept: application/json' -H 'Content-Type: application/json' \
	-X POST "$TUNNEL_URL/self-service/registration?flow=$flow_id" \
	-d "$(jq -nc --arg c "$csrf" --arg e "$EMAIL" --arg p "Ory-Smoke-Test-$RANDOM-Pw!" \
		'{method: "password", csrf_token: $c, "traits.email": $e, password: $p}')" \
	>/dev/null

# Ory Network names the session cookie after the project slug
# (ory_session_<slug>) rather than ory_kratos_session, so read whichever one the
# project actually set instead of assuming the self-hosted name.
SESSION_LINE="$(awk '$6 ~ /^(ory_session_|ory_kratos_session)/ { print $6, $7 }' "$JAR" | tail -n1)"
SESSION_COOKIE_NAME="${SESSION_LINE%% *}"
SESSION="${SESSION_LINE##* }"
[ -n "$SESSION_COOKIE_NAME" ] && [ -n "$SESSION" ] || {
	echo "could not mint a session against project $ORY_PROJECT_ID" >&2
	echo "is http://localhost:4000/ among the project's allowed return URLs?" >&2
	exit 1
}
echo "minted $SESSION_COOKIE_NAME for $EMAIL"

NETWORK="$(docker network ls \
	--filter "label=com.docker.compose.project=$PROJECT" \
	--format '{{.Name}}' | head -n1)"

status=0
docker run --rm --network "$NETWORK" \
	--env-file "$EXAMPLE_DIR/smoke.env" \
	-e "SESSION_COOKIE_VALUE=$SESSION" \
	-e "SESSION_COOKIE_NAME=$SESSION_COOKIE_NAME" \
	"$RUNNER_IMAGE" || status=$?

echo "note: this run registered '$EMAIL' in project $ORY_PROJECT_ID"

if [ "$status" -ne 0 ]; then
	printf '\033[1m== 10-network: FAILED ==\033[0m\n'
	exit "$status"
fi
printf '\033[1m== 10-network: all assertions passed ==\033[0m\n'

#!/usr/bin/env bash
# Copyright © 2026 Ory Corp
# SPDX-License-Identifier: Apache-2.0
#
# Shared smoke test for the Ory Oathkeeper examples.
#
#   _common/smoke.sh [example-directory]     (defaults to $PWD)
#
# Each example declares what it expects in a `smoke.env` next to its
# docker-compose.yml. This brings the stack up, asserts the documented behaviour
# for an anonymous and for an authenticated request, and tears it down again.
# No browser, no credentials.
#
# The assertions run in a container on the example's own Docker network, and the
# stack is started with its published ports stripped, so a test run never
# collides with anything already listening on the host. That is also why the
# assertion runner sets an explicit Host header: Oathkeeper matches its access
# rules against the request URL, and those rules all say 127.0.0.1:<port>.
#
# Set KEEP_UP=1 to leave the stack running for debugging.
#
# Requires: docker with compose v2.

set -Eeuo pipefail

EXAMPLE_DIR="$(cd "${1:-$PWD}" && pwd)"
COMMON_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
NAME="$(basename "$EXAMPLE_DIR")"
RUNNER_IMAGE="awesome-ory/smoke-runner"
OVERRIDE="$(mktemp -t smoke-override-XXXXXX).yml"
PROJECT="smoke-$(printf '%s' "$NAME" | tr -cd '[:alnum:]-' | tr '[:upper:]' '[:lower:]')"

[ -f "$EXAMPLE_DIR/smoke.env" ] || {
	echo "no smoke.env in $EXAMPLE_DIR" >&2
	exit 2
}

compose() {
	docker compose -p "$PROJECT" -f "$EXAMPLE_DIR/docker-compose.yml" -f "$OVERRIDE" "$@"
}

cleanup() {
	local code=$?
	if [ "${KEEP_UP:-0}" = "1" ]; then
		echo "KEEP_UP=1, leaving project '$PROJECT' running"
	else
		compose down -v --remove-orphans >/dev/null 2>&1 || true
	fi
	rm -f "$OVERRIDE"
	exit "$code"
}
trap cleanup EXIT

printf '\033[1m== %s ==\033[0m\n' "$NAME"

# Strip every published port. `!override` is needed because Compose appends to
# list fields when merging files rather than replacing them.
docker compose -f "$EXAMPLE_DIR/docker-compose.yml" config --format json |
	jq -r '"services:", (.services | keys[] | "  \(.):\n    ports: !override []")' \
		>"$OVERRIDE"

docker build -q -t "$RUNNER_IMAGE" "$COMMON_DIR/smoke" >/dev/null
compose up -d --build --quiet-pull

NETWORK="$(docker network ls \
	--filter "label=com.docker.compose.project=$PROJECT" \
	--format '{{.Name}}' | head -n1)"
[ -n "$NETWORK" ] || {
	echo "could not find the compose network for project $PROJECT" >&2
	exit 1
}

if ! docker run --rm --network "$NETWORK" --env-file "$EXAMPLE_DIR/smoke.env" \
	"$RUNNER_IMAGE"; then
	printf '\033[1m== %s: FAILED ==\033[0m\n' "$NAME"
	echo "--- recent oathkeeper decisions ---" >&2
	compose logs --tail=200 2>/dev/null |
		grep -Eo '"msg":"Access request (granted|denied)"|"status_code":[0-9]+' |
		tail -20 >&2 || true
	echo "(re-run with KEEP_UP=1 to inspect the stack)" >&2
	exit 1
fi

if [ -x "$EXAMPLE_DIR/smoke.extra.sh" ]; then
	printf '\033[1m-- example-specific assertions\033[0m\n'
	NETWORK="$NETWORK" PROJECT="$PROJECT" RUNNER_IMAGE="$RUNNER_IMAGE" \
		"$EXAMPLE_DIR/smoke.extra.sh" "$EXAMPLE_DIR"
fi

printf '\033[1m== %s: all assertions passed ==\033[0m\n' "$NAME"

#!/usr/bin/env bash
# Copyright © 2026 Ory Corp
# SPDX-License-Identifier: Apache-2.0
#
# Assertion runner for the Ory Oathkeeper examples. Runs *inside* the example's
# Docker network, so it needs no published ports on the host.
#
# Configuration comes from the example's smoke.env, which is passed in as
# environment variables. See _common/README.md for the full list.

set -Eeuo pipefail

JAR="$(mktemp)"
FAILURES=0
SESSION_COOKIE="ory_kratos_session"

pass() { printf '  \033[32mok\033[0m   %s\n' "$*"; }
fail() {
	printf '  \033[31mFAIL\033[0m %s\n' "$*"
	FAILURES=$((FAILURES + 1))
}
info() { printf '\033[1m%s\033[0m\n' "$*"; }

assert_eq() {
	if [ "$2" = "$3" ]; then pass "$1 = $3"; else fail "$1: want '$2', got '$3'"; fi
}

assert_contains() {
	case "$3" in
	*"$2"*) pass "$1 contains '$2'" ;;
	*) fail "$1: want '$2' in '$3'" ;;
	esac
}

: "${KRATOS_INTERNAL_URL:=http://kratos:4433}"
: "${NEEDS_SESSION:=1}"
: "${READY_TIMEOUT:=180}"
: "${EXPECT_AUTH_STATUS:=200}"

# ENTRY_INTERNAL is where the request is actually sent (a service name on the
# compose network). ENTRY_HOST is the Host header, which is what Oathkeeper
# matches its access rules against — the rules all say 127.0.0.1:<port>, so the
# two are deliberately different.
# curl's own exit status is deliberately discarded here. A connection failure
# still writes `000` to stdout via -w, and every caller below asserts on that
# output — but under `set -e` a non-zero curl kills the assignment it is
# substituted into, so `code="$(status_of)"` would abort the script before the
# settle loop or the assertion ever saw the 000.
req() {
	local path="${ENTRY_PATH:-/hello}"
	curl -sS --max-time 20 -H "Host: ${ENTRY_HOST}" "$@" "${ENTRY_INTERNAL}${path}" || true
}
status_of() { req -o /dev/null -w '%{http_code}' "$@"; }
location_of() {
	req -o /dev/null -D - "$@" | awk 'tolower($1) == "location:" { print $2 }' | tr -d '\r'
}

wait_for() {
	local url="$1" deadline=$((SECONDS + READY_TIMEOUT))
	until curl -sS -o /dev/null --max-time 5 "$url" 2>/dev/null; do
		[ "$SECONDS" -lt "$deadline" ] || {
			echo "timed out waiting for $url" >&2
			return 1
		}
		sleep 2
	done
}

# Mints a real Kratos session cookie without a browser: initialise the
# browser-typed registration flow with `Accept: application/json`, submit it
# with the CSRF token from that flow, then read `ory_kratos_session` out of the
# cookie jar. Works because the example's kratos.yml enables the `session` hook
# after password registration.
mint_session() {
	local email="smoke-$RANDOM-$RANDOM@example.com"
	local password="Ory-Smoke-Test-$RANDOM-Pw!"
	local flow flow_id csrf

	flow="$(curl -sS -c "$JAR" -H 'Accept: application/json' \
		"$KRATOS_INTERNAL_URL/self-service/registration/browser" || true)"
	flow_id="$(printf '%s' "$flow" | jq -r '.id')"
	csrf="$(printf '%s' "$flow" |
		jq -r '.ui.nodes[] | select(.attributes.name == "csrf_token") | .attributes.value')"

	curl -sS -b "$JAR" -c "$JAR" \
		-H 'Accept: application/json' -H 'Content-Type: application/json' \
		-X POST "$KRATOS_INTERNAL_URL/self-service/registration?flow=$flow_id" \
		-d "$(jq -nc --arg c "$csrf" --arg e "$email" --arg p "$password" \
			'{method: "password", csrf_token: $c, "traits.email": $e, password: $p}')" \
		>/dev/null || true

	awk -v name="$SESSION_COOKIE" '$6 == name { print $7 }' "$JAR" | tail -n1
}

# --------------------------------------------------------------------- run --

if [ "$NEEDS_SESSION" = "1" ] && [ -z "${SESSION_COOKIE_VALUE:-}" ]; then
	wait_for "$KRATOS_INTERNAL_URL/health/ready"
fi
wait_for "${READY_URL:-$ENTRY_INTERNAL}"

# An open port is not the same as a working route. Traefik, for one, accepts
# connections well before its Docker provider has discovered the containers and
# answers 404 until it has. Give the edge a moment to settle before asserting,
# but never longer than the timeout — if it stays broken, the assertions below
# still report the real status rather than hiding it behind a hang.
settle() {
	local deadline=$((SECONDS + 60)) code
	while [ "$SECONDS" -lt "$deadline" ]; do
		code="$(status_of)"
		case "$code" in
		404 | 502 | 503 | 000) sleep 2 ;;
		*) return 0 ;;
		esac
	done
}
settle

# Oathkeeper's `redirect` error handler is configured with a `when:` clause that
# only fires for `Accept: text/html`. An API client therefore gets the `json`
# fallback instead. Both halves of that are worth asserting, so the anonymous
# case is checked twice: once as an API client, once as a browser.
info "-- anonymous request (API client)"
assert_eq "anonymous status" "$EXPECT_ANON_STATUS" "$(status_of)"
[ -n "${EXPECT_ANON_LOCATION:-}" ] &&
	assert_contains "anonymous Location" "$EXPECT_ANON_LOCATION" "$(location_of)"
[ -n "${EXPECT_ANON_BODY:-}" ] &&
	assert_contains "anonymous body" "$EXPECT_ANON_BODY" "$(req)"

if [ -n "${EXPECT_ANON_BROWSER_STATUS:-}" ]; then
	info "-- anonymous request (browser)"
	assert_eq "anonymous browser status" "$EXPECT_ANON_BROWSER_STATUS" \
		"$(status_of -H 'Accept: text/html')"
	[ -n "${EXPECT_ANON_BROWSER_LOCATION:-}" ] &&
		assert_contains "anonymous browser Location" "$EXPECT_ANON_BROWSER_LOCATION" \
			"$(location_of -H 'Accept: text/html')"
fi
[ -n "${EXPECT_ANON_HEADERS:-}" ] && {
	body="$(req)"
	for pair in $EXPECT_ANON_HEADERS; do
		got="$(printf '%s' "$body" | jq -r --arg h "${pair%%=*}" '.headers[$h][0] // "<absent>"')"
		assert_eq "anonymous upstream header ${pair%%=*}" "${pair#*=}" "$got"
	done
}

# A missing cookie and a present-but-invalid one take different code paths — the
# `cookie_session` authenticator declines outright in the first case and rejects
# the session in the second. Both must deny, but not always with the same status,
# so the expectation can be overridden.
if [ "$NEEDS_SESSION" = "1" ] && [ "$EXPECT_ANON_STATUS" != "200" ]; then
	info "-- request with an invalid session cookie"
	assert_eq "invalid-cookie status" "${EXPECT_INVALID_COOKIE_STATUS:-$EXPECT_ANON_STATUS}" \
		"$(status_of -H 'Cookie: ory_kratos_session=not-a-real-session')"
fi

if [ "$NEEDS_SESSION" = "1" ]; then
	info "-- authenticated request"
	# The Ory Network lane mints the session on the host, against the tunnel,
	# and passes it in rather than having this container reach Kratos directly.
	SESSION="${SESSION_COOKIE_VALUE:-$(mint_session)}"
	[ -n "$SESSION" ] || {
		echo "could not mint a Kratos session cookie" >&2
		exit 1
	}
	# Self-hosted Kratos calls the cookie ory_kratos_session; Ory Network names
	# it after the project slug, so the caller can override the name.
	COOKIE="Cookie: ${SESSION_COOKIE_NAME:-$SESSION_COOKIE}=$SESSION"

	assert_eq "authenticated status" "$EXPECT_AUTH_STATUS" "$(status_of -H "$COOKIE")"

	[ -n "${EXPECT_AUTH_BODY:-}" ] &&
		assert_contains "authenticated body" "$EXPECT_AUTH_BODY" "$(req -H "$COOKIE")"

	if [ -n "${EXPECT_AUTH_HEADERS:-}" ]; then
		BODY="$(req -H "$COOKIE")"
		for pair in $EXPECT_AUTH_HEADERS; do
			header="${pair%%=*}"
			want="${pair#*=}"
			got="$(printf '%s' "$BODY" | jq -r --arg h "$header" '.headers[$h][0] // "<absent>"')"
			if [ "$want" = "*" ]; then
				case "$got" in
				"<absent>" | "") fail "upstream header $header: absent" ;;
				*) pass "upstream header $header present ($got)" ;;
				esac
			else
				assert_eq "upstream header $header" "$want" "$got"
			fi
		done
	fi

	# Examples that protect more than one upstream assert each of them, so a
	# routing change that silently collapses them to one is caught.
	for extra in ${AUTH_EXTRA_PATHS:-}; do
		extra_status="$(curl -sS -o /dev/null -w '%{http_code}' --max-time 20 \
			-H "Host: $ENTRY_HOST" -H "$COOKIE" "${ENTRY_INTERNAL}${extra}" || true)"
		assert_eq "authenticated status for $extra" "$EXPECT_AUTH_STATUS" "$extra_status"
	done
fi

# The Keto example is only meaningful as a before/after pair: the same
# authenticated identity is refused until a relation tuple grants it access.
# The tuple has to name the identity Kratos just minted, so it is written here
# at runtime rather than baked into a fixture.
if [ -n "${GRANT_NAMESPACE:-}" ]; then
	info "-- permission granted at runtime"
	whoami="$(curl -sS -H "Host: $ENTRY_HOST" -H "$COOKIE" \
		"$KRATOS_INTERNAL_URL/sessions/whoami" || true)"
	identity_id="$(printf '%s' "$whoami" | jq -r '.identity.id // empty')"
	[ -n "$identity_id" ] && [ "$identity_id" != "null" ] || {
		echo "could not read the identity id from /sessions/whoami" >&2
		exit 1
	}

	curl -sS -X PUT "${KETO_WRITE_URL}/admin/relation-tuples" \
		-H 'Content-Type: application/json' \
		-d "$(jq -nc --arg ns "$GRANT_NAMESPACE" --arg obj "$GRANT_OBJECT" \
			--arg rel "$GRANT_RELATION" --arg sub "$identity_id" \
			'{namespace: $ns, object: $obj, relation: $rel, subject_id: $sub}')" \
		>/dev/null || {
		echo "could not write the relation tuple to Keto at $KETO_WRITE_URL" >&2
		exit 1
	}

	assert_eq "authenticated status after the grant" "${EXPECT_AUTH_STATUS_AFTER_GRANT:-200}" \
		"$(status_of -H "$COOKIE")"
fi

# Proxying a websocket is its own thing: assert that the upgrade actually
# completes through Oathkeeper rather than just that the page loads. curl sends
# a real handshake, and a server that accepts it answers 101.
if [ -n "${WS_PATH:-}" ]; then
	info "-- websocket upgrade"
	ws_key="$(head -c 16 /dev/urandom | base64)"
	# A successful upgrade leaves the connection open, so curl would block
	# waiting for frames and never report a status. Read the response headers
	# instead and let the timeout end the request.
	ws_head="$(curl -sS -i --max-time 5 \
		-H "Host: $ENTRY_HOST" ${COOKIE:+-H "$COOKIE"} \
		-H 'Connection: Upgrade' -H 'Upgrade: websocket' \
		-H 'Sec-WebSocket-Version: 13' -H "Sec-WebSocket-Key: $ws_key" \
		"${ENTRY_INTERNAL}${WS_PATH}" 2>/dev/null || true)"
	case "$ws_head" in
	*"101 Switching Protocols"*) pass "websocket upgrade returned 101" ;;
	*) fail "websocket upgrade: no 101, got '$(printf '%s' "$ws_head" | head -n1)'" ;;
	esac
fi

# Examples whose edge proxy rewrites Oathkeeper's answer (nginx turns a 401 into
# a 302) assert the raw decision separately, against the decision API.
if [ -n "${DECISION_URL:-}" ]; then
	info "-- decision API"
	dec_status="$(curl -sS -o /dev/null -w '%{http_code}' -H "Host: ${ENTRY_HOST}" "$DECISION_URL" || true)"
	assert_eq "decision status (anonymous)" "${EXPECT_DECISION_STATUS:-401}" "$dec_status"
	[ -n "${EXPECT_DECISION_BODY:-}" ] &&
		assert_contains "decision body" "$EXPECT_DECISION_BODY" \
			"$(curl -sS -H "Host: ${ENTRY_HOST}" "$DECISION_URL")"
fi

exit "$([ "$FAILURES" -gt 0 ] && echo 1 || echo 0)"

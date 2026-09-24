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
req() {
	local path="${ENTRY_PATH:-/hello}"
	curl -sS --max-time 20 -H "Host: ${ENTRY_HOST}" "$@" "${ENTRY_INTERNAL}${path}"
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
		"$KRATOS_INTERNAL_URL/self-service/registration/browser")"
	flow_id="$(printf '%s' "$flow" | jq -r '.id')"
	csrf="$(printf '%s' "$flow" |
		jq -r '.ui.nodes[] | select(.attributes.name == "csrf_token") | .attributes.value')"

	curl -sS -b "$JAR" -c "$JAR" \
		-H 'Accept: application/json' -H 'Content-Type: application/json' \
		-X POST "$KRATOS_INTERNAL_URL/self-service/registration?flow=$flow_id" \
		-d "$(jq -nc --arg c "$csrf" --arg e "$email" --arg p "$password" \
			'{method: "password", csrf_token: $c, "traits.email": $e, password: $p}')" \
		>/dev/null

	awk '$6 == "ory_kratos_session" { print $7 }' "$JAR" | tail -n1
}

# --------------------------------------------------------------------- run --

if [ "$NEEDS_SESSION" = "1" ]; then
	wait_for "$KRATOS_INTERNAL_URL/health/ready"
fi
wait_for "${READY_URL:-$ENTRY_INTERNAL}"

# Oathkeeper's `redirect` error handler is configured with a `when:` clause that
# only fires for `Accept: text/html`. An API client therefore gets the `json`
# fallback instead. Both halves of that are worth asserting, so the anonymous
# case is checked twice: once as an API client, once as a browser.
info "-- anonymous request (API client)"
assert_eq "anonymous status" "$EXPECT_ANON_STATUS" "$(status_of)"
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

# A missing cookie makes the `cookie_session` authenticator decline outright,
# which is a different code path from an invalid session. Both must deny.
if [ "$NEEDS_SESSION" = "1" ] && [ "$EXPECT_ANON_STATUS" != "200" ]; then
	info "-- request with an invalid session cookie"
	assert_eq "invalid-cookie status" "$EXPECT_ANON_STATUS" \
		"$(status_of -H 'Cookie: ory_kratos_session=not-a-real-session')"
fi

if [ "$NEEDS_SESSION" = "1" ]; then
	info "-- authenticated request"
	SESSION="$(mint_session)"
	[ -n "$SESSION" ] || {
		echo "could not mint a Kratos session cookie" >&2
		exit 1
	}
	COOKIE="Cookie: ory_kratos_session=$SESSION"

	assert_eq "authenticated status" "$EXPECT_AUTH_STATUS" "$(status_of -H "$COOKIE")"

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
fi

# Examples whose edge proxy rewrites Oathkeeper's answer (nginx turns a 401 into
# a 302) assert the raw decision separately, against the decision API.
if [ -n "${DECISION_URL:-}" ]; then
	info "-- decision API"
	dec_status="$(curl -sS -o /dev/null -w '%{http_code}' -H "Host: ${ENTRY_HOST}" "$DECISION_URL")"
	assert_eq "decision status (anonymous)" "${EXPECT_DECISION_STATUS:-401}" "$dec_status"
	[ -n "${EXPECT_DECISION_BODY:-}" ] &&
		assert_contains "decision body" "$EXPECT_DECISION_BODY" \
			"$(curl -sS -H "Host: ${ENTRY_HOST}" "$DECISION_URL")"
fi

exit "$([ "$FAILURES" -gt 0 ] && echo 1 || echo 0)"

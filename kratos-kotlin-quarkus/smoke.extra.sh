#!/usr/bin/env bash
# Copyright © 2026 Ory Corp
# SPDX-License-Identifier: Apache-2.0

# The app renders Kratos's login and registration forms itself, so this drives
# them the way a browser would: Kratos redirects to the app, the app fetches the
# flow server-side and renders it, and the form posts back to Kratos.
# `--connect-to` keeps every URL on 127.0.0.1, where the browser sees both, so
# the cookie jar shares Kratos's cookies with the app exactly as a browser does.
set -Eeuo pipefail

docker run --rm -i --network "$NETWORK" --entrypoint bash "$RUNNER_IMAGE" <<'SH'
set -Eeuo pipefail

APP=http://127.0.0.1:8080
KRATOS=http://127.0.0.1:4433
JAR="$(mktemp)"
FAILURES=0
EMAIL="smoke-$RANDOM-$RANDOM@example.com"
PASSWORD="Ory-Smoke-Test-$RANDOM-Pw!"

pass() { printf '  \033[32mok\033[0m   %s\n' "$*"; }
fail() {
	printf '  \033[31mFAIL\033[0m %s\n' "$*"
	FAILURES=$((FAILURES + 1))
}
expect_eq() { if [ "$2" = "$3" ]; then pass "$1"; else fail "$1: want '$2', got '$3'"; fi; }
expect_in() {
	case "$3" in
	*"$2"*) pass "$1" ;;
	*) fail "$1: want '$2' in '$(printf '%s' "$3" | head -c 300)'" ;;
	esac
}

browser() {
	curl -sS --max-time 20 -b "$JAR" -c "$JAR" \
		--connect-to 127.0.0.1:8080:quarkus:8080 \
		--connect-to 127.0.0.1:4433:kratos:4433 "$@"
}
status_of() { browser -o /dev/null -w '%{http_code}' "$@" || echo 000; }
redirect_of() { browser -o /dev/null -w '%{http_code} %{redirect_url}' -H 'Accept: text/html' "$@" || echo 000; }

# Posts a form the app rendered: its hidden inputs, the fields "typed in", and
# the value of the button that was pressed. Prints the status and redirect.
submit() {
	local page="$1" button="$2" action pair
	shift 2
	local args=()
	action="$(printf '%s' "$page" | grep -o '<form action="[^"]*"' | sed 's/^<form action="//; s/"$//; s/&amp;/\&/g')"
	while IFS= read -r pair; do
		[ -n "$pair" ] && args+=(--data-urlencode "$pair")
	done < <(printf '%s' "$page" | grep -o '<input type="hidden" name="[^"]*" value="[^"]*"' |
		sed 's/.*name="\([^"]*\)" value="\([^"]*\)"/\1=\2/')
	for pair in "$@" "$button"; do args+=(--data-urlencode "$pair"); done
	redirect_of "${args[@]}" "$action"
}

until curl -sS -o /dev/null --max-time 5 http://kratos:4433/health/ready 2>/dev/null; do sleep 2; done

printf '\033[1m%s\033[0m\n' "-- registration, in two steps, through the app's form"
init="$(redirect_of "$KRATOS/self-service/registration/browser")"
expect_in "Kratos sends the browser to the app's registration page" "303 $APP/auth/registration?flow=" "$init"
page="$(browser "${init#* }")"
expect_in "the app renders the first step from the flow" 'name="traits.name"' "$page"
expect_in "the first step posts back to Kratos" "$KRATOS/self-service/registration?flow=" "$page"

step="$(submit "$page" method=profile "traits.email=$EMAIL" traits.name=Smoke)"
expect_in "Kratos returns to the app for the second step" "303 $APP/auth/registration?flow=" "$step"
page="$(browser "${step#* }")"
expect_in "the app renders the password step" 'name="password"' "$page"

done_="$(submit "$page" method=password "password=$PASSWORD")"
expect_eq "registering signs the browser in" "303 $APP/" "$done_"

printf '\033[1m%s\033[0m\n' "-- the protected page"
expect_eq "/recipe with the new session" 200 "$(status_of "$APP/recipe")"
expect_in "/recipe shows the recipe" "perfect recipe" "$(browser "$APP/recipe")"
expect_eq "/recipe with a forged session cookie" 307 \
	"$(curl -sS -o /dev/null -w '%{http_code}' --connect-to 127.0.0.1:8080:quarkus:8080 \
		-H 'Cookie: ory_kratos_session=not-a-real-session' "$APP/recipe")"

printf '\033[1m%s\033[0m\n' "-- logout"
out="$(redirect_of "$APP/auth/logout")"
expect_in "the app sends the browser to Kratos's logout URL" "303 $KRATOS/self-service/logout?token=" "$out"
back="$(redirect_of "${out#* }")"
expect_eq "Kratos revokes the session and returns to the app" "303 $APP/" "$back"
expect_eq "/recipe after logout" 307 "$(status_of "$APP/recipe")"

printf '\033[1m%s\033[0m\n' "-- login through the app's form"
init="$(redirect_of "$KRATOS/self-service/login/browser")"
expect_in "Kratos sends the browser to the app's login page" "303 $APP/auth/login?flow=" "$init"
page="$(browser "${init#* }")"
expect_in "the app renders the login form" 'name="identifier"' "$page"
done_="$(submit "$page" method=password "identifier=$EMAIL" "password=$PASSWORD")"
expect_eq "logging in signs the browser in" "303 $APP/" "$done_"
expect_eq "/recipe after logging in" 200 "$(status_of "$APP/recipe")"

printf '\033[1m%s\033[0m\n' "-- flows the app can't render"
expect_eq "a login page without a flow starts one" "303 $KRATOS/self-service/login/browser" \
	"$(redirect_of "$APP/auth/login")"
expect_eq "an unknown registration flow starts a new one" "303 $KRATOS/self-service/registration/browser" \
	"$(redirect_of "$APP/auth/registration?flow=00000000-0000-0000-0000-000000000000")"

exit "$([ "$FAILURES" -gt 0 ] && echo 1 || echo 0)"
SH

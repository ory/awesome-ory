#!/usr/bin/env bash
# Copyright © 2026 Ory Corp
# SPDX-License-Identifier: Apache-2.0
#
# Runs `make test` for every project, tolerating failures, and writes the result
# to .reports/example-health.json. That file is how a repeated agent run knows
# what was already green without re-deriving the repo — see AGENTS.md.

set -uo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
REPORT="$REPO_ROOT/.reports/example-health.json"
mkdir -p "$(dirname "$REPORT")"

started="$(date -u +%Y-%m-%dT%H:%M:%SZ)"
results=()
failed=0

for project in "$@"; do
	printf '\033[1m>> %s\033[0m\n' "$project"
	log="$(mktemp)"
	if make --no-print-directory -C "$REPO_ROOT/$project" test >"$log" 2>&1; then
		if grep -q '^skip:' "$log"; then
			status=skipped
		else
			status=pass
		fi
	else
		status=fail
		failed=$((failed + 1))
		tail -n 20 "$log"
	fi
	printf '   %s\n' "$status"
	results+=("$(jq -nc --arg p "$project" --arg s "$status" '{project: $p, status: $s}')")
	rm -f "$log"
done

printf '%s\n' "${results[@]}" | jq -s \
	--arg started "$started" \
	--arg finished "$(date -u +%Y-%m-%dT%H:%M:%SZ)" \
	--arg commit "$(git -C "$REPO_ROOT" rev-parse --short HEAD)" \
	'{started: $started, finished: $finished, commit: $commit, projects: .}' \
	>"$REPORT"

echo "wrote $REPORT"
exit "$([ "$failed" -gt 0 ] && echo 1 || echo 0)"

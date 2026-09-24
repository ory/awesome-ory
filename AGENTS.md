# Keeping the examples in this repo working

This file is the standing brief for an agent run against `ory/awesome-ory`. Read
it before touching anything.

It describes **how to run a maintenance pass** — the contract, the invariants,
and the traps. It is deliberately not a work list: known follow-ups live in
[`TODO.md`](TODO.md), so that this file stays true no matter how much of that
backlog has been done.

## Scope

**In scope: the example projects that live in this tree.** Keep them building,
running, and green against current Ory. Repair and modernize — bump to current,
fix what the bump breaks, and keep each example teaching the thing it was written
to teach.

**Out of scope: the curated link lists** in `README.md` and `ARCHIVE.md`. Those
are other people's repositories; the daily `closed_references` workflow and
manual janitor passes look after them. Do not edit them as part of a maintenance
run.

## Never touch

These files are generated from [`ory/meta`](https://github.com/ory/meta) and
carry a `AUTO-GENERATED, DO NOT EDIT!` header. Edits are silently reverted on the
next template sync, so changing them wastes a run:

```bash
grep -rl "AUTO-GENERATED, DO NOT EDIT" --include="*.md" --include="*.yml" . \
  | grep -v AGENTS.md
```

Grep for the marker rather than trusting a list — `ory/meta` adds files over
time. Today it covers `CONTRIBUTING.md`, `CODE_OF_CONDUCT.md`, `SECURITY.md`,
most of `.github/` and most of `.github/workflows/`. Two workflows, `format.yml`
and `spellcheck.yml`, carry no marker and are this repo's own. A genuinely new
workflow has to be a new filename.

Note that `CONTRIBUTING.md` tells contributors to run `go test -tags sqlite ./...`
and to make CI pass. That is generic Ory boilerplate; it does not describe this
repo. The contract below is what actually applies.

Also off limits: `assets/`, `LICENSE`, and `git push --force`.

## The test contract

> **`make test` in any project directory exits 0 if and only if that example
> works.** It provisions what it needs, asserts, and cleans up. No credentials,
> no browser, no manual steps.

At the root:

| Command                                     | What it does                                                               |
| ------------------------------------------- | -------------------------------------------------------------------------- |
| `make test`                                 | the whole suite — the default gate                                         |
| `make -C oathkeeper/03-header-mutator test` | one example                                                                |
| `make health`                               | runs everything, tolerates failures, writes `.reports/example-health.json` |
| `make test-network`                         | the credentialed lane; skips loudly without a project                      |

The suite is serial by design — the examples share Docker resources and port
names. **`make -j` is not supported.**

`make test` must leave the working tree clean. `format.yml` gates on
`git diff --exit-code`, so run `make format` before committing.

## How the examples are tested

The examples used to be verified by opening a browser and, for the mutator ones,
reading container logs. They are not any more, and the technique is worth
understanding before you change a test.

`_common/smoke.sh` brings an example's stack up, runs
`_common/smoke/assert.sh` in a container **on the example's own Docker network**,
and tears it down. Two consequences worth knowing:

- **The stack is started with its published ports stripped**, so a run never
  collides with whatever is already listening on the host, and two examples can
  be debugged side by side.
- **The assertion runner sets an explicit `Host` header.** Oathkeeper matches
  access rules against the request URL, and every rule in this repo says
  `127.0.0.1:<port>`. The runner therefore talks to `oathkeeper:4455` while
  claiming to be `127.0.0.1:8080`.

A session is minted without a browser by driving the browser-typed registration
flow with `Accept: application/json` and reading `ory_kratos_session` out of a
curl cookie jar. This works because `_common/kratos/kratos.yml` enables the
`session` hook after password registration. If you ever remove that hook, the
harness has to register and then log in instead.

Each example declares what it expects in a `smoke.env` next to its
`docker-compose.yml`. Adding an example means writing that file, not writing a
new script.

## Invariants

Things a well-meaning change breaks silently:

- **Use `127.0.0.1`, never `localhost`.** `curl localhost:8080` does not match
  the access rules and returns a 404 from Oathkeeper.
- **Entry ports are 8080 — except 08, which is 8000.** Envoy listens on 10000
  and is published on 8000.
- **05–08 are decision-API mode**: their rules have no `upstream:`. That is the
  point of those examples. Do not "fix" it by adding one.
- **nginx rewrites Oathkeeper's 401 into a 302** via `error_page 401`, so in
  05/06 the JSON error handler is only observable on the decision API at `:4456`.
- **Oathkeeper's `redirect` error handler has a `when: accept: text/html`
  clause.** API clients get the `json` fallback and a 401; browsers get the 302.
  Both are asserted; do not "correct" one to match the other.
- **12's anonymous request succeeds.** It lists `cookie_session` _then_
  `anonymous`, so an unauthenticated visitor arrives as `guest`. The assertion is
  that the subject differs, not that access is refused.
- **`hello` listens on `:8090`** inside the network and echoes its request
  headers as JSON. That echo is what makes the mutator examples assertable —
  keep it.
- **Tests must not depend on the self-service UI or the mail catcher.** Both sit
  behind the `ui` profile so `make test` does not even pull them.
- Every example must stay runnable with `docker compose up` from its own
  directory, and its README must describe what the test asserts.
- **Pin every image to an exact tag.** `latest`, a floating minor like `v0.40`,
  and a bare `nginx` are all bugs — the repo got into its previous state that way.

## Deciding what is stale

Resolve real versions; never write one from memory.

| What                    | Where to look                                                                                                                                   |
| ----------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------- |
| Ory OSS images          | `curl -s "https://hub.docker.com/v2/repositories/oryd/kratos/tags?page_size=20"` — likewise keto, oathkeeper, hydra, kratos-selfservice-ui-node |
| Ory CLI                 | `gh release list --repo ory/cli`                                                                                                                |
| Ory SDKs                | PyPI `ory-client`, NuGet `Ory.Client`, pub.dev `ory_client`                                                                                     |
| Go                      | `go list -m -u all` in each module                                                                                                              |
| Python                  | `pip list --outdated`                                                                                                                           |
| .NET                    | `dotnet list package --outdated`                                                                                                                |
| Dart                    | `flutter pub outdated`                                                                                                                          |
| Runtime support windows | [endoflife.date](https://endoflife.date) for postgres, python, dotnet, django                                                                   |

Ory's open-source services share one version line — kratos, keto, oathkeeper and
hydra all release together. Check one, and pin them together.

Do not record version numbers in this file. They rot exactly the way the repo
did. `.reports/example-health.json` holds them instead.

## The loop

One item per run. This is what keeps a repeated run from thrashing across
half-finished changes.

1. Read `.reports/example-health.json` for what was green last time and what was
   already looked at.
2. `make health`.
3. Pick the highest-value item that is red or stale **and unblocked**. If nothing
   is red and nothing is stale, take the top item from `TODO.md` instead.
4. Fix it on a branch — see below.
5. Re-run that project's `make test`, then the full suite.
6. `make format`, commit, update the report, stop.

**Never mark something done without a green `make test` in the same run.**
Evidence, not assertion.

If a fix needs a judgement call that is not yours to make — dropping an example,
changing what it teaches, adopting a replacement library — write the options into
`TODO.md` and move to the next item rather than guessing.

## Branches and pull requests

`CONTRIBUTING.md` says unsolicited pull requests are not accepted. So: **commit
to a branch and stop.** Open a PR only when asked, and never merge one.

- Branch names continue the existing series: `vinckr/examples-janitor-0NN`.
- Commit subjects are conventional commits — `conventional_commits.yml` enforces
  it on PR titles.
- One concern per branch.

## The projects

| Project                                 | Demonstrates                     | Lane        | Notes                                              |
| --------------------------------------- | -------------------------------- | ----------- | -------------------------------------------------- |
| `oathkeeper/01-basic`                   | the `anonymous` authenticator    | OSS         | no Kratos at all, so it is the fastest test        |
| `oathkeeper/02-authenticators`          | `cookie_session` + `noop`        | OSS         |                                                    |
| `oathkeeper/03-header-mutator`          | the `header` mutator             | OSS         | asserts `X-User` is the identity id                |
| `oathkeeper/04-hydrator-mutator`        | the `hydrator` mutator           | OSS         | asserts the three injected headers                 |
| `oathkeeper/05-nginx-oathkeeper`        | nginx `auth_request`             | OSS         | also asserts the decision API directly             |
| `oathkeeper/06-nginx-hydrator`          | nginx + hydrator                 | OSS         |                                                    |
| `oathkeeper/07-traefik-decision`        | Traefik `forwardAuth`            | OSS         | Traefik needs a moment to discover containers      |
| `oathkeeper/08-envoy-header`            | Envoy `ext_authz`                | OSS         | **port 8000**                                      |
| `oathkeeper/09-oathkeeper-websockets`   | proxying websockets              | OSS         | asserts a real 101 upgrade                         |
| `oathkeeper/10-network`                 | the Ory tunnel                   | **Network** | `make test` skips; `make test-network` runs        |
| `oathkeeper/11-kratos-keto`             | Keto authorization               | OSS         | 403 before the tuple, 200 after                    |
| `oathkeeper/12-multiple-authenticators` | authenticator fallback           | OSS         | anonymous succeeds as `guest`                      |
| `kratos-oathkeeper-kong`                | Kong in front of Oathkeeper      | OSS         | Kong is DB-less; routes live in `config/kong.yaml` |
| `kratos-keto-flask`                     | Flask + Kratos + Keto            | OSS         | 403 before the tuple, 200 after                    |
| `django-ory-cloud`                      | Django + the Ory SDK             | OSS         | the integration is vendored in `mysite/ory_auth`   |
| `dotnet-ory-network`                    | ASP.NET Core + the Ory SDK       | OSS         | `ORY_BASEPATH` can point at a tunnel instead       |
| `flutter-ory-network`                   | a native app with session tokens | OSS         | `flutter test` in a pinned container; no emulator  |
| `ory-actions/vpncheck-py`               | an Ory Action webhook            | OSS         | vendors are mocked; never calls a paid API         |

## The Network lane

`make test-network` needs `ORY_PROJECT_ID` and `ORY_PROJECT_API_KEY`
(`ORY_NETWORK_*` also works). Without them it **skips with exit 0** — it must
never fail the default run for a reason that cannot be fixed in the repo.

Rules: never commit `.env`; never echo an API key; never write credentials into a
README; never `git add` a project's `.env*` except `.env.example`.

A Network run registers a throwaway identity in a real project, and pointing an
example at a project needs `http://localhost:4000/` among its
`allowed_return_urls`. Treat that as a change to someone's live tenant: snapshot
`ory get identity-config --format json` first, append with
`--add '/selfservice/allowed_return_urls/-="…"'` rather than replacing the list,
delete the identities you created, restore with `ory update identity-config
--file`, and confirm by re-reading. Do not do any of it unattended.

Three things differ from the self-hosted lane and will mislead you if you assume
otherwise:

- **The tunnel mirrors Ory's APIs at the root.** `/sessions/whoami` and
  `/ui/login`, _not_ `/.ory/sessions/whoami`. The `/.ory/` prefix is an
  `ory proxy` convention; `ory proxy` is deprecated, and paths carrying that
  prefix 404 against a tunnel.
- **`ory tunnel` refuses `--project` when `ORY_PROJECT_API_KEY` is set.** The key
  already scopes the tunnel. Passing both is an error, not a preference.
- **Ory Network names the session cookie `ory_session_<slug>`**, with the slug's
  dashes stripped — not `ory_kratos_session`. An example that copies
  `only: [ory_kratos_session]` from a self-hosted one will never see the cookie.
  `10-network` deliberately sets no `only:` for this reason.

## Known traps

Discovered the hard way; do not rediscover them.

- `_common/` was deleted in `e4d4c9cd` while eleven examples still extended it.
  Every Kratos-backed example depends on it.
- `postgres:9.6` has no arm64 image and will not run on Apple Silicon.
- Compose `extends:` does **not** copy `depends_on`, so each example declares its
  own ordering even though the service definitions are shared.
- Prettier reflows Django template tags across newlines, which Django's lexer
  rejects — it broke `base.html` twice. The **root** `.prettierignore` is what
  protects it; prettier only reads the one in the directory it is run from, so
  the per-project `django-ory-cloud/.prettierignore` does nothing during
  `make format`.
- Keto's check endpoint is `/relation-tuples/check`. The old `/check` path 404s,
  which surfaces as a 500 from Oathkeeper's `remote_json` authorizer.
- Keto's numeric-id `namespaces:` list is gone; namespaces are defined in OPL.
- Modern Envoy needs an explicit `typed_config` on the router filter.
- The Ory .NET SDK resolves a token provider for every auth scheme in the API
  description, so all three must be registered even for cookie-only flows.
- Flutter is pinned to 3.35.7 in `flutter-ory-network/Makefile`. Do not bump it
  casually — 3.44 does not build this project. See `TODO.md`.
- A `prod` Ory Network project redacts courier message bodies, so anything needing
  a one-time code or recovery link has to run against a `dev` project.
- Never reintroduce a dependency on `playground.projects.oryapis.com`. It is a
  shared public project whose UI markup changes without notice, and chasing its
  selectors is what rotted the previous tests.

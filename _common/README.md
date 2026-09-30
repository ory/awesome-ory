# Shared pieces

Services and tooling the examples share, so that a version bump or a fix happens
once rather than twelve times.

| Path                 | What it is                                                                                                                                   |
| -------------------- | -------------------------------------------------------------------------------------------------------------------------------------------- |
| `docker-compose.yml` | Kratos, its database, and — behind a `ui` profile — the self-service UI and a mail catcher. Examples pull these in with `extends:`.          |
| `kratos/`            | The Kratos configuration and identity schema those services use.                                                                             |
| `hello/`             | The upstream "protected" service. Echoes the request headers it received as JSON, which is how the mutator examples show what they injected. |
| `hydrator/`          | The hydrator webhook used by the hydrator-mutator examples.                                                                                  |
| `smoke.sh`           | Runs an example's smoke test. See below.                                                                                                     |
| `smoke/`             | The assertion runner image that `smoke.sh` executes.                                                                                         |
| `health.sh`          | Runs every project's `make test` and records the result.                                                                                     |

Compose `extends:` copies a service definition but **not** its `depends_on`, so
each example declares its own startup ordering even though the definitions are
shared.

## Running one example's smoke test

`make test-smoke` at the repository root tests the assertion runner itself
against a local HTTP server in an isolated container. It checks retries and
ensures failed transfers cannot pass because they received an expected status,
header, or partial body. These regression tests also run as part of `make test`.

```bash
make -C oathkeeper/03-header-mutator test   # or: _common/smoke.sh <example-dir>
KEEP_UP=1 make -C oathkeeper/03-header-mutator test   # leave the stack running
```

`smoke.sh` starts the stack **with its published ports stripped** and runs the
assertions in a container on the example's own Docker network. A test run
therefore never competes for a port on the host, and two examples can be up at
once.

Because nothing is published, the runner addresses services by name and sets the
`Host` header separately — Oathkeeper matches access rules against the request
URL, and the rules in this repo all say `127.0.0.1:<port>`.

The session is minted without a browser: the runner drives the browser-typed
registration flow with `Accept: application/json` and reads `ory_kratos_session`
out of a curl cookie jar. That depends on the `session` hook after password
registration in `kratos/kratos.yml`.

## Writing a `smoke.env`

Each example declares what it expects in a `smoke.env` next to its
`docker-compose.yml`.

| Variable                                              | Meaning                                                                |
| ----------------------------------------------------- | ---------------------------------------------------------------------- |
| `ENTRY_INTERNAL`                                      | where the request is sent, e.g. `http://oathkeeper:4455`               |
| `ENTRY_HOST`                                          | the `Host` header, e.g. `127.0.0.1:8080` — what the access rules match |
| `ENTRY_PATH`                                          | the path to request (default `/hello`)                                 |
| `READY_URL`                                           | what to poll before asserting (default `ENTRY_INTERNAL`)               |
| `NEEDS_SESSION`                                       | `0` for examples with no Kratos                                        |
| `EXPECT_ANON_STATUS`                                  | status for an anonymous API client                                     |
| `EXPECT_ANON_LOCATION`                                | substring expected in the anonymous `Location`                         |
| `EXPECT_ANON_BODY`                                    | substring expected in the anonymous body                               |
| `EXPECT_ANON_HEADERS`                                 | `Name=Value` pairs the upstream should have received                   |
| `EXPECT_ANON_BROWSER_STATUS`                          | status with `Accept: text/html` — usually the redirect                 |
| `EXPECT_ANON_BROWSER_LOCATION`                        | substring expected in that redirect                                    |
| `EXPECT_INVALID_COOKIE_STATUS`                        | status for a bogus cookie (defaults to the anonymous status)           |
| `EXPECT_AUTH_STATUS`                                  | status once signed in                                                  |
| `EXPECT_AUTH_BODY`                                    | substring expected in the signed-in body                               |
| `EXPECT_AUTH_HEADERS`                                 | `Name=Value` pairs, or `Name=*` for "present, any value"               |
| `AUTH_EXTRA_PATHS`                                    | further paths that should also return `EXPECT_AUTH_STATUS`             |
| `WS_PATH`                                             | path to attempt a websocket upgrade against                            |
| `DECISION_URL`                                        | Oathkeeper's decision API, for edges that rewrite its answer           |
| `EXPECT_DECISION_STATUS`                              | status expected there (default `401`)                                  |
| `GRANT_NAMESPACE` / `GRANT_OBJECT` / `GRANT_RELATION` | a Keto tuple to write **after** the first authenticated assertion      |
| `KETO_WRITE_URL`                                      | Keto's write API, e.g. `http://keto:4467`                              |
| `EXPECT_AUTH_STATUS_AFTER_GRANT`                      | status once that tuple exists (default `200`)                          |

The grant variables are what turn the Keto examples into a before/after pair: the
tuple names the identity the run just registered, so it has to be written at
runtime rather than kept as a fixture.

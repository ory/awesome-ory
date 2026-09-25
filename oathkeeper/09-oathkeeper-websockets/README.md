## Ory Oathkeeper proxying websockets

This example shows an example of using Ory Oathkeeper to proxy websocket
traffic.

## Overview

- [Define WebSockets Rules](https://ory.com/docs/oathkeeper/guides/proxy-websockets)

## Develop

Ory Oathkeeper Access Rules: [`access-rules.yml`](./oathkeeper/access-rules.yml)
Ory Oathkeeper Configuration: [`oathkeeper.yml`](./oathkeeper/oathkeeper.yml)

### Prerequisites

1. [Docker](https://docs.docker.com/get-docker/)
1. [Ory Oathkeeper](https://www.ory.com/docs/oathkeeper/install)

### Run locally

```bash
git clone git@github.com:ory/awesome-ory
cd awesome-ory/oathkeeper/09-oathkeeper-websockets
docker compose --profile ui up --build
```

Wait for a couple of seconds and open `http://127.0.0.1:8080/`. The websocket itself is at `/ws`

You can find read configuration of
[`access-rules.yml`](./oathkeeper/access-rules.yml) and
[`oathkeeper.yml`](./oathkeeper/oathkeeper.yml)

### Run tests

```bash
make test
```

This brings the stack up, asserts the behaviour this example demonstrates, and
tears it down again. It needs no credentials and no browser: the test mints a
real Ory session with `curl` and replays it against the proxy.

## Contribute

Feel free to
[open a discussion](https://github.com/ory/awesome-ory/discussions/new) to provide
feedback or talk about ideas, or
[open an issue](https://github.com/ory/awesome-ory/issues/new) if you want to add
your example to the repository or encounter a bug. You can contribute to Ory in
many ways, see the
[Ory Contributing Guidelines](https://www.ory.com/docs/ecosystem/contributing)
for more information.

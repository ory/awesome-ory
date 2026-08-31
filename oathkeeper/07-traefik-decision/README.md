# Traefik and Ory Oathkeeper

This example shows an example of using Ory Oathkeeper with Traefik.

## Overview

Request flow:

1. Request lands on Traefik
1. Traefik uses forwardauth to forward authentication to
   http://oathkeeper/decision API
1. `cookie_sesion` authentication checks authentication and returns request back
   to Traefik
1. Hydrator adds an additional header to the request
1. Traefik proxies request to `hello` service

For more information, please refer to
[the Ory Oathkeeper documentation](https://www.ory.com/docs/oathkeeper).

## Develop

Ory Oathkeeper Access Rules: [`access-rules.yml`](./oathkeeper/access-rules.yml)
Ory Oathkeeper Configuration: [`oathkeeper.yml`](./oathkeeper/oathkeeper.yml)

### Prerequisites

1. [Docker](https://docs.docker.com/get-docker/)
1. [Traefik](https://doc.traefik.io/traefik/getting-started/install-traefik/)
1. [Ory Oathkeeper](https://www.ory.com/docs/oathkeeper/install)

### Run locally

```bash
git clone git@github.com:ory/examples
cd examples/oathkeeper/07-traefik-decision
docker-compose up --build
```

1. Wait for a couple of seconds and open `http://127.0.0.1:8080/hello`.
1. Sign up for a new account.
1. Open `http://127.0.0.1:8080/hello` again.

## Contribute

Feel free to
[open a discussion](https://github.com/ory/examples/discussions/new) to provide
feedback or talk about ideas, or
[open an issue](https://github.com/ory/examples/issues/new) if you want to add
your example to the repository or encounter a bug. You can contribute to Ory in
many ways, see the
[Ory Contributing Guidelines](https://www.ory.com/docs/ecosystem/contributing)
for more information.

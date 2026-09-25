# Example using Nginx with Ory Oathkeeper as decision API

This example shows an example of using Ory Oathkeeper with Nginx.

## Overview

Request flow:

1. Request lands on Nginx
1. Nginx uses the subrequest authentication module and passes it to Ory
   Oathkeepers decisions API.
1. `cookie_session` authentication checks authentication and returns it to
   Nginx.
1. Nginx proxies request to `hello` microservice.

For more information, please refer to
[the Ory Oathkeeper documentation](https://www.ory.com/docs/oathkeeper).

## Develop

Ory Oathkeeper Access Rules: [`access-rules.yml`](./oathkeeper/access-rules.yml)
Ory Oathkeeper Configuration: [`oathkeeper.yml`](./oathkeeper/oathkeeper.yml)

### Prerequisites

1. [Docker](https://docs.docker.com/get-docker/)
1. [Nginx](https://www.nginx.com/resources/wiki/start/topics/tutorials/install/)
1. [Ory Oathkeeper](https://www.ory.com/docs/oathkeeper/install)

### Run locally

```bash
git clone git@github.com:ory/awesome-ory
cd awesome-ory/oathkeeper/05-nginx-oathkeeper
docker compose --profile ui up --build
```

1. Wait for a couple of seconds and open `http://127.0.0.1:8080/hello`.
1. Sign up for a new account.
1. Open `http://127.0.0.1:8080/hello` again.

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

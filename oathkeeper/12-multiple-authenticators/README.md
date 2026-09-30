## Example using Ory Oathkeeper with cookie session authenticator & header mutator

This example shows a basic configuration of `cookie_session` and `anonymous`
authenticator with the `header` mutator for Ory Oathkeeper.

## Overview

This example implements the following flow:

1. Validates incoming requests at Ory Kratos using `cookie_session`
   authenticator
1. Modifies request and sends `X-User` with value returned on previous step
1. Sends only authenticated requests to `hello` microservice with
   `X-User: user_id` header

For more information, please refer to
[the Ory Oathkeeper documentation](https://www.ory.com/docs/oathkeeper)

## Develop

Ory Oathkeeper Access Rules: [`access-rules.yml`](./oathkeeper/access-rules.yml)
Ory Oathkeeper Configuration: [`oathkeeper.yml`](./oathkeeper/oathkeeper.yml)

### Prerequisites

1. [Docker](https://docs.docker.com/get-docker/)
1. [Ory Oathkeeper](https://www.ory.com/docs/oathkeeper/install)

## Run locally

```bash
git clone git@github.com:ory/awesome-ory
cd awesome-ory/oathkeeper/03-header-mutator
docker compose --profile ui up --build
```

Wait for a couple of seconds and open `http://127.0.0.1:8080/hello`

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

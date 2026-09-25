## Example using Ory Cloud with Ory Keto self-hosted

This example shows a basic configuration of `cookie_session` authenticator for
Ory Oathkeeper and `remote_json` for authorization.

## Develop

Ory Oathkeeper Access Rules: [`access-rules.yml`](./oathkeeper/access-rules.yml)
Ory Oathkeeper Configuration: [`oathkeeper.yml`](./oathkeeper/oathkeeper.yml)

For more information, please refer to
[the Ory Oathkeeper documentation](https://www.ory.com/docs/oathkeeper)

### Prerequisites

1. [Docker](https://docs.docker.com/get-docker/)
1. [Ory Oathkeeper](https://www.ory.com/docs/oathkeeper/install)
1. [Ory Keto](https://www.ory.com/docs/keto/install)

### Run locally

```bash
   git clone git@github.com:ory/awesome-ory
   cd awesome-ory/oathkeeper/11_kratos_keto
   docker compose --profile ui up --build
```

Wait for a couple of seconds and open
[http://127.0.0.1:8080/hello](http://127.0.0.1:8080/hello). You will be
redirected to the login page. After logging in, you still cannot access
[/hello](http://127.0.0.1:8080/hello). To get the required access, visit
[http://127.0.0.1:8080/grant-access](http://127.0.0.1:8080/grant-access).

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

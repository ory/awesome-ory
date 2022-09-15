# Basic example for Ory Oathkeeper

This repo is an example of using Ory Oathkeeper as simple reverse proxy without
any additional mutations or authentication/authorization checks.

## Develop

Ory Oathkeeper Access Rules: [`access-rules.yml`](./oathkeeper/access-rules.yml)
Ory Oathkeeper Configuration: [`oathkeeper.yml`](./oathkeeper/oathkeeper.yml)

### Prerequisites

1. [Docker](https://docs.docker.com/get-docker/)
1. [Ory Oathkeeper](https://www.ory.sh/docs/oathkeeper/install)

### Run locally

```bash
git clone git@github.com:ory/examples
cd examples/oathkeeper/01-basic
docker-compose up
```

Wait for a couple of seconds and open `http://127.0.0.1/hello`.

## Contribute

Feel free to
[open a discussion](https://github.com/ory/examples/discussions/new) to provide
feedback or talk about ideas, or
[open an issue](https://github.com/ory/examples/issues/new) if you want to add
your example to the repository or encounter a bug. You can contribute to Ory in
many ways, see the
[Ory Contributing Guidelines](https://www.ory.sh/docs/ecosystem/contributing)
for more information.

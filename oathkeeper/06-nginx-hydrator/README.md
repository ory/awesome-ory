# Example using Nginx with Ory Oathkeeper as decision API

This example shows an example of using Ory Oathkeeper with Nginx and hydrator
mutator.

## Overview

Request flow:

1. Request lands on Nginx
1. Nginx uses subrequest authentication module and passes it to
   oathkeeper/decisions API
1. `cookie_sesion` authentication checks authentication
1. Makes request to `hydrator` service and adds `X-User-Name` header
1. Nginx proxies request to `hello` service with `X-User: user_id`,
   `X-user-Name: andrew` headers

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
git clone git@github.com:ory/examples
cd examples/oathkeeper/06-nginx-hydrator
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

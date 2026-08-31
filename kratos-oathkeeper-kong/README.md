# API Gateway using Kong, Ory Kratos & Ory Oathkeeper

This tutorial shows an example using Kong API gateway, Ory Kratos, and Ory
Oathkeeper.

Read the tutorial on the Ory blog:

- [Secure microservices with Kong and Ory](https://www.ory.com/zero-trust-api-security-ory-tutorial/)

## Overview

- A simple Go HTTP API that exposes `/greet` endpoint and listens `:8090` port.
- [Ory Oathkeeper](https://www.ory.com/docs/oathkeeper/install) as Zero Trust
  Identity Access Proxy.
- [Ory Kratos](https://www.ory.com/docs/kratos/install) to manage identities and
  users.
- [Kong](https://konghq.com/install#kong-community) as ingress for incoming HTTP
  traffic.

Request Flow:

User -> Kong -> Ory Oathkeeper -> Ory Kratos -> Go API

![Architecture using Oathkeeper, Kratos, and Kong](./kong.png)

Ory Oathkeeper checks the incoming request for presence of `ory_kratos_session`
and does the following steps:

1. Proxies request to Go HTTP API if the identity check passes in Ory Kratos.
2. Redirects user to the Kratos UI if the identity check fails.

## Develop

### Prerequisites

1. Go 1.1x
1. [Docker](https://docs.docker.com/get-docker/)
1. make

### Run locally

#### Using docker-compose

```bash
docker-compose up --build
```

Open `http://127.0.0.1:8000/hello` in your browser and follow the login flow

The docker-compose command builds a go webserver, runs all services, and exposes
the following ports:

1. HTTP `:8001` and SSL `:8444` ports for Kong Gateway admin API
1. HTTP `:8000` and SSL `:8444` ports for Kong Gateway Proxy listener
1. HTTP `:4433` and `:4434` are public and admin APIs of Ory Kratos
1. HTTP `:4436` for Mailslurper
1. HTTP `:4455` for UI interface

## Configuring Kong

```bash
bash kong.config.sh
```

That command creates an `/greet` endpoint on `secure-api` service and creates a
reverse proxy for Ory Oathkeeper.

## Contribute

Feel free to
[open a discussion](https://github.com/ory/examples/discussions/new) to provide
feedback or talk about ideas, or
[open an issue](https://github.com/ory/examples/issues/new) if you want to add
your example to the repository or encounter a bug. You can contribute to Ory in
many ways, see the
[Ory Contributing Guidelines](https://www.ory.com/docs/ecosystem/contributing)
for more information.

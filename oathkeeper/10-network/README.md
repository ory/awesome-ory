## Example using Ory Oathkeeper with cookie session authenticator & Ory Network

This example shows a basic configuration of `cookie_session` authenticator for
Ory Oathkeeper using Ory Network as identity provider.

## Develop

Ory Oathkeeper Access Rules: [`access-rules.yml`](./oathkeeper/access-rules.yml)
Ory Oathkeeper Configuration: [`oathkeeper.yml`](./oathkeeper/oathkeeper.yml)

For more information, please refer to
[the Ory Oathkeeper documentation](https://www.ory.com/docs/oathkeeper)

### Prerequisites

1. [Ory Network Developer project](https://console.ory.com/)
1. [Docker](https://docs.docker.com/get-docker/)
1. [Ory Oathkeeper](https://www.ory.com/docs/oathkeeper/install)

### Run locally

```bash
   git clone git@github.com:ory/awesome-ory
   cd awesome-ory/oathkeeper/10-network
```

Change $ORY_PROJECT_SLUG in https://$ORY_PROJECT_SLUG.projects.oryapis.com in
`oathkeeper.yml` and `acces-rules.yml` to your Ory Network project slug.

```
   docker-compose up --build
```

Wait for a couple of seconds and open `http://127.0.0.1:8080/hello`.

### Run tests

```bash
make test-network
```

This example needs an Ory Network project, because what it demonstrates is
Oathkeeper checking sessions through the Ory tunnel. Plain `make test` skips it.

## Contribute

Feel free to
[open a discussion](https://github.com/ory/awesome-ory/discussions/new) to provide
feedback or talk about ideas, or
[open an issue](https://github.com/ory/awesome-ory/issues/new) if you want to add
your example to the repository or encounter a bug. You can contribute to Ory in
many ways, see the
[Ory Contributing Guidelines](https://www.ory.com/docs/ecosystem/contributing)
for more information.

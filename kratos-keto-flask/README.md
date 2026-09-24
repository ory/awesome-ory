# Flask App using Ory Kratos and Ory Keto

This example integrates [Ory Kratos](https://www.ory.com/docs/kratos) and
[Ory Keto](https://www.ory.com/docs/keto) in a Flask application: Kratos answers
_who is this_, and Keto answers _are they allowed_.

Follow the tutorial based on this code:

- [Securing Your Flask Application Using Kratos and Keto](https://www.ory.com/securing-flask-application-using-kratos-and-keto/)

## Overview

The home page does two checks on every request:

1. It forwards the visitor's `ory_kratos_session` cookie to Kratos'
   `/sessions/whoami`. Without a session, the visitor is sent to the login UI.
2. It asks Keto whether that identity has the `read` relation on the `homepage`
   object. Without the relation tuple, the visitor gets a 403.

The second step is the point of the example. Being signed in is not the same as
being allowed, so a freshly registered identity is refused until a tuple grants
it access.

The permission subject is the Kratos identity ID. Note that it is deliberately
_not_ the email address: identities can change their email, and a permission
that silently follows an address is a permission you cannot reason about.

## Develop

### Prerequisites

- [Docker](https://docs.docker.com/get-docker/) with Compose v2.

Everything else — Kratos, Keto, Postgres, the self-service UI and a mail
catcher — comes from `docker-compose.yml` and the shared services in
[`_common`](../_common).

### Run locally

```bash
git clone git@github.com:ory/awesome-ory
cd awesome-ory/kratos-keto-flask
docker compose --profile ui up --build
```

The `ui` profile adds Ory's self-service UI on
[127.0.0.1:4455](http://127.0.0.1:4455) and the mail catcher on
[127.0.0.1:8025](http://127.0.0.1:8025); leave it off if you only want the API.

1. Register an account at [127.0.0.1:4455](http://127.0.0.1:4455).
2. Open [127.0.0.1:5001](http://127.0.0.1:5001). You are signed in, and refused
   with a 403 — Keto has no tuple for you yet.
3. Grant yourself access, using the identity ID the app shows you:

   ```bash
   curl -X PUT http://127.0.0.1:4467/admin/relation-tuples \
     -H 'Content-Type: application/json' \
     -d '{"namespace":"app","object":"homepage","relation":"read","subject_id":"<your-identity-id>"}'
   ```

4. Reload. You are in.

The permission model itself lives in
[`keto/namespaces.keto.ts`](keto/namespaces.keto.ts), written in
[Ory Permission Language](https://www.ory.com/docs/keto/reference/ory-permission-language).

### Run tests

```bash
make test
```

This brings the stack up and asserts the whole story end to end: anonymous
visitors are redirected, an invalid session is refused, a valid session is still
refused until the relation tuple is written, and allowed once it is. It needs no
credentials and no browser.

## Contribute

Feel free to
[open a discussion](https://github.com/ory/awesome-ory/discussions/new) to provide
feedback or talk about ideas, or
[open an issue](https://github.com/ory/awesome-ory/issues/new) if you want to add
your example to the repository or encounter a bug. You can contribute to Ory in
many ways, see the
[Ory Contributing Guidelines](https://www.ory.com/docs/ecosystem/contributing)
for more information.

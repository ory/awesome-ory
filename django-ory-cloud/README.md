# Secure a Django application using Ory Cloud

This repo demonstrates how you can use self-hosted Ory Kratos with Django apps.
Ory Network support is incomplete and tracked in [TODO.md](../TODO.md).
This app is not for production use and serves as an example of integration.

Read the tutorial on the Ory blog:

- [Add Authentication to your Django Application](https://www.ory.com/secure-django-app-using-ory/)

## Overview

- Generated using the default `django-admin startproject` command.
- Uses sqlite3 as the database backend.
- Consider using
  [django-cookiecutter](https://github.com/cookiecutter/cookiecutter-django)

## Run locally with Docker

From `django-ory-cloud`, run:

```bash
docker compose --profile ui up --build
```

Open http://127.0.0.1:8000. The `ui` profile starts the login and registration
UI on http://127.0.0.1:4455. After signing in, return to the Django app.

## Develop with Python

Use Python 3.13 and Docker for the local Kratos services. From
`django-ory-cloud`, run:

```bash
docker compose --profile ui up -d kratos kratos-selfservice-ui-node mailpit
python3 -m venv .venv
. .venv/bin/activate
python -m pip install -r requirements.txt
export ORY_SDK_URL=http://127.0.0.1:4433
export ORY_UI_URL=http://127.0.0.1:4455
cd mysite
python manage.py migrate
python manage.py runserver 127.0.0.1:8000
```

Open http://127.0.0.1:8000. Use `127.0.0.1` consistently so the app and Kratos
share the session cookie.

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

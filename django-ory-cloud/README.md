# Secure a Django application using Ory Cloud

This repo demonstrates how you can use Ory Cloud or Ory Kratos with Django apps.
This app is not for production use and serves as an example of integration.

Read the tutorial on the Ory blog:

- [Add Authentication to your Django Application](https://www.ory.com/secure-django-app-using-ory/)

## Overview

- Generated using the default `django-admin startproject` command.
- Uses sqlite3 as the database backend.
- Consider using
  [django-cookiecutter](https://github.com/cookiecutter/cookiecutter-django)

## Develop

### Prerequisites

1. Python 3.10
1. [Poetry](https://python-poetry.org/) - Python dependency manager.
1. [Docker](https://docs.docker.com/get-docker/) (if you want to self-host Ory
   Kratos)

## Environment variables

```bash
export ORY_SDK_URL=https://playground.projects.oryapis.com
export ORY_UI_URL=https://playground.projects.oryapis.com/ui
```

## Run locally

```bash
git clone git@github.com:ory/examples
cd examples/django-ory-cloud
poetry install
cd mysite
poetry run python manage.py migrate
poetry run python manage.py runserver
```

Open http://127.0.0.1:8000 for testing

## Contribute

Feel free to
[open a discussion](https://github.com/ory/examples/discussions/new) to provide
feedback or talk about ideas, or
[open an issue](https://github.com/ory/examples/issues/new) if you want to add
your example to the repository or encounter a bug. You can contribute to Ory in
many ways, see the
[Ory Contributing Guidelines](https://www.ory.com/docs/ecosystem/contributing)
for more information.

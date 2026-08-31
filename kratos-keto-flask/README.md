# Flask App using Ory Kratos and Ory Keto

This example integrates [Ory Kratos](https://www.ory.com/kratos/docs/quickstart/)
and [Ory Keto](https://www.ory.com/keto/docs/quickstart/) in a flask application.

Follow the tutorial based on this code:

- [Securing Your Flask Application Using Kratos and Keto](https://www.ory.com/securing-flask-application-using-kratos-and-keto/)

## Overview

![Architecture Overview](https://mermaid.ink/img/pako:eNptkktOIzEQhq9S8iojMSIShIUXSIjHCM2CRZRdS1CyK2kraVeP7RYKCGkuMIs5AbsR7DgTJ-AIlNsN0ZB4U9Xu7__rId8rw5aUVpF-deQNnTlcBGwqD3JaDMkZ16JP0EUKgBFmEiOM3h7_Pr3-_vP2-O9F0uch_batWwZMHGeXWfuzz0E-RvrwcDLZgQ_IJ5zBg4Md4HyFcZm5iz4Z6cl4PN5lSIl7uxyz29GRUIXLM30_Pu6tNFy15AGh5oZaXFBBcJVg6hYeLv1-jrO23OfT6zb6H5TghsP6uox8HSlGx_4GDPPS0bauTFiEzpJPLq0hBXQpwjxwA_u3NWPjgLxt2flULGgVCbBLdVYYTGSHe283PZ8YI-XhlH0KvNpRW9ahwdRkZImFlf2I55f5P4txcHdblQa3vEcN05pvY29hpKo0Bzz_zzErim7TTz5qTzUUGnRWHuJ9_lcp0TVUKS2pxbCsVOUfhOtaKwOfW5c4KD1H6W5PSXs8XXujdAodfUDDSx6oh3d7rfx0)

A docker volume `node-modules` is created to store NPM packages and is reused
across the dev and prod versions of the application. For the purposes of DB
testing with `sqlite`, the file `dev.db` is mounted to all containers. This
volume mount should be removed from `docker-compose.yml` if a production DB
server is used.

## Develop

### Prerequisites

- [Ory Keto](https://www.ory.com/docs/keto/install) as an access control service.
- [Ory Kratos](https://www.ory.com/docs/kratos/install) with UI to authenticate
  users.
- [PostgreSQL](https://www.postgresql.org/download/) as an RDBMS.
- [Flask cookiecutter](https://github.com/cookiecutter-flask/cookiecutter-flask)
  to bootstrap the project structure.

This app can be run completely using `Docker` and `docker-compose`. **Using
Docker is recommended, as it guarantees the application is run using compatible
versions of Python and Node**.

### Environmental Variables

The list of `environment:` variables in the `docker-compose.yml` file takes
precedence over any variables specified in `.env`.

### Run locally

#### Using Docker

To run the development version of the app

```bash
docker-compose up
```

Go to `http://localhost:8080`. You will see a pretty welcome screen.

To run any commands use the `Flask CLI`

```bash
docker-compose run --rm manage <<COMMAND>>
```

For example, to initialize a database you would run

```bash
docker-compose run --rm manage db init
docker-compose run --rm manage db migrate
docker-compose run --rm manage db upgrade
```

#### Without Docker

Run the following commands to bootstrap your environment if you are unable to
run the application using Docker

```bash
cd examples/kratos-keto-flask
pipenv install --dev
pipenv shell
FLASK_APP=autoapp flask run
```

Go to `http://localhost:8080`. You will see a pretty welcome screen.

#### Database Initialization (locally)

Once you have installed your DBMS, run the following to create your app's
database tables and perform the initial migration:

```bash
flask db init
flask db migrate
flask db upgrade
```

#### Shell

To open the interactive shell, run

```bash
docker-compose run --rm manage db shell  # If running with Docker
flask shell # If running locally without Docker
```

By default, you will have access to the flask `app`.

#### Troubleshooting Windows

You may have this error running this example on windows because of missing
`greenlet` and `colorama` packages:

```bash
pkg_resources.DistributionNotFound: The 'greenlet!=0.4.17; python_version >= "3" and (platform_machine == "aarch64" or (platform_machine == "ppc64le" or (platform_machine == "x86_64" or (platform_machine == "amd64" or (platform_machine == "AMD64" or (platform_machine == "win32" or platform_machine == "WIN32"))))))' distribution was not found and is required by SQLAlchemy
```

You can fix it by running:

```bash
pipenv shell
pip install greenlet colorama
```

## Run Tests

To run all tests, run

```bash
docker-compose run --rm manage test
flask test # If running locally without Docker
```

To run the linter, run

```bash
docker-compose run --rm manage lint
flask lint # If running locally without Docker
```

The `lint` command will attempt to fix any linting/style errors in the code. If
you only want to know if the code will pass CI and do not wish for the linter to
make changes, add the `--check` argument.

## Deploy

When using Docker, reasonable production defaults are set in
`docker-compose.yml`

```text
FLASK_ENV=production
FLASK_DEBUG=0
```

Therefore, starting the app in "production" mode is as simple as

```bash
docker-compose up flask-prod
```

If running without Docker

```bash
export FLASK_ENV=production
export FLASK_DEBUG=0
export DATABASE_URL="<YOUR DATABASE URL>"
npm run build   # build assets with webpack
flask run       # start the flask server
```

## Migrations

Whenever a database migration needs to be made. Run the following commands

```bash
docker-compose run --rm manage db migrate
flask db migrate # If running locally without Docker
```

This will generate a new migration script. Then run

```bash
docker-compose run --rm manage db upgrade
flask db upgrade # If running locally without Docker
```

To apply the migration.

For a full migration command reference, run
`docker-compose run --rm manage db --help`.

If you will deploy your application remotely (e.g on Heroku) you should add the
`migrations` folder to version control. You can do this after `flask db migrate`
by running the following commands

```bash
git add migrations/*
git commit -m "Add migrations"
```

Make sure folder `migrations/versions` is not empty.

## Asset Management

Files placed inside the `assets` directory and its subdirectories (excluding
`js` and `css`) will be copied by webpack's `file-loader` into the
`static/build` directory. In production, the plugin `Flask-Static-Digest` zips
the webpack content and tags them with a MD5 hash. As a result, you must use the
`static_url_for` function when including static content, as it resolves the
correct file name, including the MD5 hash. For example

```html
<link
  rel="shortcut icon"
  href="{{static_url_for('static', filename='build/img/favicon.ico') }}"
/>
```

If all of your static files are managed this way, then their filenames will
change whenever their contents do, and you can ask Flask to tell web browsers
that they should cache all your assets forever by including the following line
in `.env`:

```text
SEND_FILE_MAX_AGE_DEFAULT=31556926  # one year
```

## Contribute

Feel free to
[open a discussion](https://github.com/ory/examples/discussions/new) to provide
feedback or talk about ideas, or
[open an issue](https://github.com/ory/examples/issues/new) if you want to add
your example to the repository or encounter a bug. You can contribute to Ory in
many ways, see the
[Ory Contributing Guidelines](https://www.ory.com/docs/ecosystem/contributing)
for more information.

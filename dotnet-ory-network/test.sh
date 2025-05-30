#!/bin/bash

set -euxo pipefail

make docker-run

trap "exit" INT TERM ERR
trap 'make docker-stop' EXIT

npx -q wait-on -v -t 300000 tcp:localhost:4000 tcp:localhost:5286
npm run test:e2e

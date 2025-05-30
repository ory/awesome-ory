#!/bin/sh

ORY_SDK_URL="${ORY_PROJECT_URL}" /usr/local/bin/ory tunnel --dev "http://localhost:${APP_PORT}" &

ORY_BASEPATH="http://localhost:${ORY_TUNNEL_PORT}" ASPNETCORE_URLS="http://+:${APP_PORT}" exec "$@"

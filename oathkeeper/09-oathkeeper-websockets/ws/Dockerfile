# Copyright © 2026 Ory Corp
# SPDX-License-Identifier: Apache-2.0

FROM golang:1.27-alpine AS builder

WORKDIR /build
COPY go.mod go.sum ./
RUN go mod download
COPY main.go index.html ./
RUN CGO_ENABLED=0 go build -o /usr/bin/ws .

FROM alpine:3.22
WORKDIR /app
COPY --from=builder /build/index.html ./index.html
COPY --from=builder /usr/bin/ws /usr/bin/ws
EXPOSE 8080
ENTRYPOINT ["/usr/bin/ws"]

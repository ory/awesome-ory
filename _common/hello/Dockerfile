# Copyright © 2026 Ory Corp
# SPDX-License-Identifier: Apache-2.0

FROM golang:1.27-alpine AS builder

WORKDIR /build
COPY go.mod ./
COPY main.go ./
RUN CGO_ENABLED=0 go build -o /usr/bin/hello .

FROM alpine:3.22
COPY --from=builder /usr/bin/hello /usr/bin/hello
EXPOSE 8090
ENTRYPOINT ["/usr/bin/hello"]

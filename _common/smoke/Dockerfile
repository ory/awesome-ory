# Copyright © 2026 Ory Corp
# SPDX-License-Identifier: Apache-2.0

# The assertion runner for the Oathkeeper examples. It joins the example's own
# Docker network so the smoke tests never need a free port on the host.
FROM alpine:3.22
RUN apk add --no-cache bash curl jq
COPY assert.sh /usr/local/bin/assert.sh
RUN chmod +x /usr/local/bin/assert.sh
ENTRYPOINT ["/usr/local/bin/assert.sh"]

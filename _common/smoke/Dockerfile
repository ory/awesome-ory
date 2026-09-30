# Copyright © 2026 Ory Corp
# SPDX-License-Identifier: Apache-2.0

# The assertion runner for the Oathkeeper examples. It joins the example's own
# Docker network so the smoke tests never need a free port on the host.
FROM alpine:3.22 AS runner
RUN apk add --no-cache bash curl jq
COPY assert.sh /usr/local/bin/assert.sh
RUN chmod +x /usr/local/bin/assert.sh
ENTRYPOINT ["/usr/local/bin/assert.sh"]

FROM runner AS test
RUN apk add --no-cache python3
COPY test_assert.py /usr/local/bin/test_assert.py
ENTRYPOINT ["python3", "/usr/local/bin/test_assert.py"]

# The default image remains the assertion runner used by the examples.
FROM runner AS smoke

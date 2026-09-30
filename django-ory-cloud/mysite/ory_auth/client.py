# Copyright © 2026 Ory Corp
# SPDX-License-Identifier: Apache-2.0

"""The Ory SDK client, configured from Django settings."""

import ory_client
from django.conf import settings
from ory_client.api.frontend_api import FrontendApi


def frontend_api():
    """A FrontendApi pointed at ORY_SDK_URL.

    Everything this example does is a browser flow, so the Frontend API is all
    it needs — no API key, no admin endpoints. Requests are authenticated by
    forwarding the user's own session cookie.
    """
    configuration = ory_client.Configuration(host=settings.ORY_SDK_URL)
    return FrontendApi(ory_client.ApiClient(configuration))

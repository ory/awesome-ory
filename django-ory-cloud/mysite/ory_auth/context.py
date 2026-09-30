# Copyright © 2026 Ory Corp
# SPDX-License-Identifier: Apache-2.0

"""Makes the Ory self-service URLs available to every template."""

import logging

from django.conf import settings
from ory_client.exceptions import ApiException

from .client import frontend_api
from .middleware import SESSION_COOKIE

log = logging.getLogger(__name__)


def processor(request):
    """Adds `login_url`, `signup_url` and `logout_url` to the template context.

    Logging out is the odd one: it needs a one-time token from Ory rather than a
    fixed URL, so it is fetched for the current session and is absent when
    nobody is signed in.
    """
    return {
        "login_url": f"{settings.ORY_UI_URL}/login",
        "signup_url": f"{settings.ORY_UI_URL}/registration",
        "logout_url": _logout_url(request),
    }


def _logout_url(request):
    cookie = request.COOKIES.get(SESSION_COOKIE)
    if not cookie:
        return None

    try:
        flow = frontend_api().create_browser_logout_flow(
            cookie=f"{SESSION_COOKIE}={cookie}"
        )
    except ApiException:
        return None
    except Exception:  # pragma: no cover - network trouble
        log.exception("could not create a logout flow")
        return None

    return flow.logout_url

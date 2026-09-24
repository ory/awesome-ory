# Copyright © 2026 Ory Corp
# SPDX-License-Identifier: Apache-2.0

"""Resolves the Ory session on every request."""

import logging

from ory_client.exceptions import ApiException

from .client import frontend_api

log = logging.getLogger(__name__)

SESSION_COOKIE = "ory_kratos_session"


class OryUser:
    """The signed-in user, as far as the templates are concerned.

    Deliberately not a `django.contrib.auth` user: this example keeps identities
    in Ory rather than mirroring them into Django's user table, so there is no
    second copy of the user to keep in sync.
    """

    def __init__(self, session=None):
        self.session = session

    @property
    def is_authenticated(self):
        return self.session is not None

    @property
    def is_anonymous(self):
        return self.session is None

    @property
    def id(self):
        return self.session.identity.id if self.session else None

    @property
    def traits(self):
        return self.session.identity.traits if self.session else {}

    @property
    def email(self):
        return self.traits.get("email") if self.session else None

    def __str__(self):
        return self.email or "anonymous"


class AuthenticationMiddleware:
    """Turns the Ory session cookie into `request.user`.

    Ory is the source of truth, so the session is checked against it on each
    request rather than trusted from a local cookie.
    """

    def __init__(self, get_response):
        self.get_response = get_response

    def __call__(self, request):
        request.user = OryUser(self._session(request))
        return self.get_response(request)

    def _session(self, request):
        cookie = request.COOKIES.get(SESSION_COOKIE)
        if not cookie:
            return None

        try:
            session = frontend_api().to_session(cookie=f"{SESSION_COOKIE}={cookie}")
        except ApiException:
            # 401 is the normal answer for an expired or invalid session.
            return None
        except Exception:  # pragma: no cover - network trouble, not auth trouble
            log.exception("could not reach Ory to check the session")
            return None

        return session if session.active else None

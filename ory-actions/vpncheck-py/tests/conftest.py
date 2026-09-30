# Copyright © 2026 Ory Corp
# SPDX-License-Identifier: Apache-2.0

"""Shared fixtures for the vpncheck tests.

Each of the three modules reads its credentials at import time and raises if
they are missing, so the environment has to be set before the import happens —
hence the `autouse` fixture below and the imports inside the tests.

None of these tests call the IP reputation vendors. Every outbound request is
intercepted by `responses`, so the suite runs offline and costs nothing.
"""

import os

import pytest

CREDENTIALS = {
    "BEARER_TOKEN": "test-token",
    "FOCSEC_API_KEY": "test-focsec-key",
    "IPQS_API_KEY": "test-ipqs-key",
    "VPNAPIIO_API_KEY": "test-vpnapi-key",
}


@pytest.fixture(autouse=True, scope="session")
def _credentials():
    os.environ.update(CREDENTIALS)


@pytest.fixture
def client(request):
    """A Flask test client for the module named by the test's `vendor` mark."""
    import importlib

    module = importlib.import_module(request.param)
    module.app.config.update(TESTING=True)
    return module.app.test_client()


def auth(token="test-token"):
    return {"Authorization": f"Bearer {token}"}

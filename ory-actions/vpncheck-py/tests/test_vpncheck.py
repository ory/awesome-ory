# Copyright © 2026 Ory Corp
# SPDX-License-Identifier: Apache-2.0

"""Tests for the three vpncheck Ory Action implementations.

The three modules are the same webhook written against three different IP
reputation vendors, so the auth and payload handling is tested once per module
and the block rules are tested per vendor, since each reads a different shape of
response.

No vendor is ever contacted: `responses` intercepts every outbound request.
"""

import pytest
import responses

from conftest import auth

VENDORS = ["focsec", "ipqs", "vpnapi"]

VENDOR_URLS = {
    "focsec": "https://api.focsec.com/v1/ip/1.2.3.4",
    "ipqs": "https://www.ipqualityscore.com/api/json/ip/test-ipqs-key/1.2.3.4",
    "vpnapi": "https://vpnapi.io/api/1.2.3.4",
}

# The smallest response each vendor can return that means "this IP is fine".
CLEAN = {
    "focsec": {"is_vpn": False, "is_tor": False, "iso_code": "de"},
    "ipqs": {"success": True, "fraud_score": 0, "vpn": False, "tor": False},
    "vpnapi": {"security": {"vpn": False, "tor": False}, "location": {"country_code": "DE"}},
}


def post(client, body=None, headers=None):
    return client.post(
        "/vpncheck",
        json={"ip_address": "1.2.3.4"} if body is None else body,
        headers=auth() if headers is None else headers,
    )


def ory_message(response):
    """Ory expects rejections in a specific envelope; dig out the text."""
    return response.get_json()["messages"][0]["messages"][0]["text"]


# --------------------------------------------------------------- the envelope


@pytest.mark.parametrize("client", VENDORS, indirect=True)
def test_missing_authorization_header_is_unauthorized(client):
    assert post(client, headers={}).status_code == 401


@pytest.mark.parametrize("client", VENDORS, indirect=True)
def test_wrong_bearer_token_is_unauthorized(client):
    assert post(client, headers=auth("not-the-token")).status_code == 401


@pytest.mark.parametrize("client", VENDORS, indirect=True)
def test_missing_ip_address_is_rejected_in_orys_message_format(client):
    response = post(client, body={})
    assert response.status_code == 400
    assert ory_message(response) == "Cannot determine Client IP address"


@pytest.mark.parametrize("client", VENDORS, indirect=True)
@responses.activate
def test_a_clean_ip_is_allowed(client, request):
    vendor = request.node.callspec.params["client"]
    responses.add(responses.GET, VENDOR_URLS[vendor], json=CLEAN[vendor], status=200)
    assert post(client).status_code == 200


@pytest.mark.parametrize("client", VENDORS, indirect=True)
@responses.activate
def test_the_check_fails_open_when_the_vendor_is_unreachable(client, request):
    """A reputation lookup that errors must not lock users out."""
    vendor = request.node.callspec.params["client"]
    responses.add(responses.GET, VENDOR_URLS[vendor], status=500)

    response = post(client)
    assert response.status_code == 200
    assert "warning" in response.get_json()


# ------------------------------------------------------------- the block rules


@pytest.mark.parametrize("client", ["focsec"], indirect=True)
@responses.activate
@pytest.mark.parametrize(
    "payload,expected",
    [
        ({"is_vpn": True}, "Request blocked: VPN"),
        ({"is_tor": True}, "Request blocked: Tor"),
        ({"iso_code": "ru"}, "Request blocked: Geolocation"),
    ],
)
def test_focsec_block_rules(client, payload, expected):
    responses.add(responses.GET, VENDOR_URLS["focsec"], json=payload, status=200)
    response = post(client)
    assert response.status_code == 400
    assert ory_message(response) == expected


@pytest.mark.parametrize("client", ["ipqs"], indirect=True)
@responses.activate
@pytest.mark.parametrize(
    "payload,expected",
    [
        ({"success": False}, "Can't verify IP address"),
        (
            {"success": True, "fraud_score": 80},
            "Authentication failed: IP address cannot be verified",
        ),
        ({"success": True, "vpn": True}, "Authentication failed: Please disable your VPN."),
        ({"success": True, "tor": True}, "Authentication failed: Please disable Tor."),
        ({"success": True, "iso_code": "ru"}, "Request blocked: Geolocation"),
    ],
)
def test_ipqs_block_rules(client, payload, expected):
    responses.add(responses.GET, VENDOR_URLS["ipqs"], json=payload, status=200)
    response = post(client)
    assert response.status_code == 400
    assert ory_message(response) == expected


@pytest.mark.parametrize("client", ["vpnapi"], indirect=True)
@responses.activate
@pytest.mark.parametrize(
    "payload,expected",
    [
        ({"security": {"vpn": True}}, "Request blocked: VPN"),
        ({"security": {"tor": True}}, "Request blocked: Tor"),
        (
            {"security": {}, "location": {"country_code": "RU"}},
            "Request blocked: Geolocation",
        ),
    ],
)
def test_vpnapi_block_rules(client, payload, expected):
    responses.add(responses.GET, VENDOR_URLS["vpnapi"], json=payload, status=200)
    response = post(client)
    assert response.status_code == 400
    assert ory_message(response) == expected

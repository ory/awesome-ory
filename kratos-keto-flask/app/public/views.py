# Copyright © 2026 Ory Corp
# SPDX-License-Identifier: Apache-2.0

# -*- coding: utf-8 -*-
"""Public section, including homepage and signup."""
import requests

from flask import Blueprint, render_template, session, redirect, request, abort
from config import settings

blueprint = Blueprint("public", __name__, static_folder="../static")


HTTP_STATUS_FORBIDDEN = 403


@blueprint.route("/", methods=["GET", "POST"])
def home():
    """Home page."""

    if 'ory_kratos_session' not in request.cookies:
        return redirect(settings.KRATOS_UI_URL)

    response = requests.get(
        f"{settings.KRATOS_EXTERNAL_API_URL}/sessions/whoami",
        cookies=request.cookies
    )
    active = response.json().get('active')
    if not active:
        abort(HTTP_STATUS_FORBIDDEN)

    email = response.json().get('identity', {}).get('traits', {}).get('email').replace('@', '')

    # Check permissions

    response = requests.get(
        f"{settings.KETO_API_READ_URL}/check",
        params={
            "namespace": "app",
            "object": "homepage",
            "relation": "read",
            "subject_id": email,
        }
    )
    if not response.json().get("allowed"):
        abort(HTTP_STATUS_FORBIDDEN)

    return render_template("public/home.html")

@blueprint.route("/oathkeeper", methods=["GET", "POST"])
def oathkeeper():
    """ An example route to demo oathkeeper integration with Kratos """
    return {"message": "greetings"}

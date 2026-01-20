# Copyright © 2026 Ory Corp
# SPDX-License-Identifier: Apache-2.0

# -*- coding: utf-8 -*-
"""Extensions module. Each extension is initialized in the app factory located in app.py."""
from flask_debugtoolbar import DebugToolbarExtension
from flask_migrate import Migrate
from flask_sqlalchemy import SQLAlchemy
from flask_static_digest import FlaskStaticDigest

db = SQLAlchemy()
migrate = Migrate()
debug_toolbar = DebugToolbarExtension()
flask_static_digest = FlaskStaticDigest()

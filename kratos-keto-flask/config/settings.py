# Copyright © 2026 Ory Corp
# SPDX-License-Identifier: Apache-2.0

"""Application configuration.

Uses .env file for local development
"""

from environs import Env

env = Env()
env.read_env()

ENV = env.str("FLASK_ENV", default="production")
DEBUG = ENV == "development"

SECRET_KEY = env.str("SECRET_KEY", default="something-insecure")

# Kratos variables for the application
KRATOS_EXTERNAL_API_URL = env.str(
    "KRATOS_EXTERNAL_API_URL", default="http://127.0.0.1:4433"
)
KRATOS_UI_URL = env.str("KRATOS_UI_URL", default="http://127.0.0.1:4455")

# Keto
KETO_API_READ_URL = env.str("KETO_API_READ_URL", default="http://127.0.0.1:4466")

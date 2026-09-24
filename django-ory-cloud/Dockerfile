# Copyright © 2026 Ory Corp
# SPDX-License-Identifier: Apache-2.0

FROM python:3.13-slim

WORKDIR /app

COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

COPY mysite ./mysite

WORKDIR /app/mysite
EXPOSE 8000
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]

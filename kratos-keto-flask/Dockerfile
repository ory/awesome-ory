# Copyright © 2026 Ory Corp
# SPDX-License-Identifier: Apache-2.0

FROM python:3.13-slim

WORKDIR /app

COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

EXPOSE 5001
CMD ["flask", "run", "-p", "5001", "-h", "0.0.0.0"]

# Copyright © 2026 Ory Corp
# SPDX-License-Identifier: Apache-2.0

"""Exercise the complete assertion runner against HTTP transport failures."""

import collections
import http.server
import json
import os
from pathlib import Path
import subprocess
import tempfile
import threading
import time
import unittest


class Handler(http.server.BaseHTTPRequestHandler):
    def log_message(self, *_):
        pass

    def do_GET(self):
        cookie = self.headers.get("Cookie", "")
        browser = self.headers.get("Accept") == "text/html"
        key = (self.path, cookie, browser)
        self.server.calls[key] += 1
        count = self.server.calls[key]
        mode = self.server.mode
        if self.path == "/world" and mode == "empty-response":
            self.close_connection = True
            return
        if self.path == "/hello" and mode == "retry" and count == 1:
            self.close_connection = True
            return

        status = 200
        body = b'{"headers":{"X-User":["test-user"]}}'
        headers = {}
        partial = False
        if self.path == "/hello":
            authenticated = cookie == "ory_kratos_session=valid"
            status = 200 if authenticated else 401
            if not authenticated and browser:
                status = 302
                headers["Location"] = "/login"
            if mode == "auth-body" and authenticated and count > 1:
                partial = True
            if mode == "anon-body" and not cookie and not browser and count > 2:
                partial = True
            if mode == "location" and browser and count > 1:
                partial = True
        elif self.path == "/world":
            partial = mode in ("partial", "timeout")
        elif self.path == "/decision":
            status = 401
            partial = mode == "decision-status" or (
                mode == "decision-body" and count > 1
            )
        elif self.path == "/sessions/whoami":
            body = b'{"identity":{"id":"test-user"}}'
            partial = mode == "whoami"
        elif self.path == "/self-service/registration/browser":
            body = json.dumps(
                {
                    "id": "flow",
                    "ui": {"nodes": [{"attributes": {"name": "csrf_token", "value": "csrf"}}]},
                }
            ).encode()
            partial = mode == "registration-flow"

        self.respond(status, body, headers, partial)
        if self.path == "/world" and mode == "timeout":
            # Keep the body unfinished beyond the runner's actual 20s timeout.
            time.sleep(22)

    def do_POST(self):
        self.respond(
            200,
            b"{}",
            {"Set-Cookie": "ory_kratos_session=valid; Path=/"},
            self.server.mode == "registration-submit",
        )

    def respond(self, status, body, headers, partial):
        self.send_response(status)
        for name, value in headers.items():
            self.send_header(name, value)
        self.send_header("Content-Length", str(len(body) + (100 if partial else 0)))
        self.end_headers()
        self.wfile.write(body)
        self.wfile.flush()
        self.close_connection = True


class AssertionRunnerTests(unittest.TestCase):
    def run_runner(self, mode="ok", **overrides):
        with http.server.ThreadingHTTPServer(("127.0.0.1", 0), Handler) as server:
            server.mode = mode
            server.calls = collections.Counter()
            thread = threading.Thread(target=server.serve_forever, daemon=True)
            thread.start()
            self.addCleanup(thread.join)
            url = f"http://127.0.0.1:{server.server_port}"
            with tempfile.TemporaryDirectory() as tmpdir:
                env = dict(
                    os.environ,
                    ENTRY_INTERNAL=url,
                    ENTRY_HOST="127.0.0.1:8000",
                    READY_URL=f"{url}/ready",
                    KRATOS_INTERNAL_URL=url,
                    SESSION_COOKIE_VALUE="valid",
                    NEEDS_SESSION="1",
                    EXPECT_ANON_STATUS="401",
                    EXPECT_AUTH_STATUS="200",
                    TMPDIR=tmpdir,
                )
                env.update({key: value.replace("{url}", url) for key, value in overrides.items()})
                try:
                    result = subprocess.run(
                        ["bash", str(Path(__file__).with_name("assert.sh"))],
                        env=env,
                        capture_output=True,
                        text=True,
                        timeout=30,
                    )
                finally:
                    server.shutdown()
        return result

    def assert_failed(self, result, message):
        output = result.stdout + result.stderr
        self.assertEqual(result.returncode, 1, output)
        self.assertIn(message, output)

    def test_complete_responses_pass_including_expected_http_errors(self):
        result = self.run_runner(
            AUTH_EXTRA_PATHS="/world",
            EXPECT_ANON_BODY="test-user",
            EXPECT_ANON_HEADERS="X-User=test-user",
            EXPECT_ANON_BROWSER_STATUS="302",
            EXPECT_ANON_BROWSER_LOCATION="/login",
            EXPECT_AUTH_BODY="test-user",
            EXPECT_AUTH_HEADERS="X-User=*",
            DECISION_URL="{url}/decision",
            EXPECT_DECISION_BODY="test-user",
        )
        self.assertEqual(result.returncode, 0, result.stdout + result.stderr)

    def test_settle_retries_transport_failure(self):
        result = self.run_runner("retry", NEEDS_SESSION="0")
        self.assertEqual(result.returncode, 0, result.stdout + result.stderr)
        self.assertIn("anonymous status = 401", result.stdout)
        self.assertIn("Empty reply", result.stderr)

    def test_extra_path_transport_failures_do_not_pass(self):
        for mode in ("empty-response", "partial", "timeout"):
            with self.subTest(mode=mode):
                result = self.run_runner(mode, AUTH_EXTRA_PATHS="/world")
                self.assert_failed(result, "authenticated status for /world: want '200', got '000'")

    def test_truncated_decision_status_does_not_pass(self):
        result = self.run_runner("decision-status", DECISION_URL="{url}/decision")
        self.assert_failed(result, "decision status (anonymous): want '401', got '000'")

    def test_partial_bodies_and_headers_do_not_pass(self):
        cases = [
            ("auth-body", {"EXPECT_AUTH_BODY": "test-user"}, "authenticated body"),
            ("auth-body", {"EXPECT_AUTH_HEADERS": "X-User=*"}, "authenticated upstream headers"),
            ("anon-body", {"EXPECT_ANON_BODY": "test-user"}, "anonymous body"),
            ("anon-body", {"EXPECT_ANON_HEADERS": "X-User=test-user"}, "anonymous upstream headers"),
            ("location", {"EXPECT_ANON_BROWSER_STATUS": "302", "EXPECT_ANON_BROWSER_LOCATION": "/login"}, "anonymous browser Location"),
            ("decision-body", {"DECISION_URL": "{url}/decision", "EXPECT_DECISION_BODY": "test-user"}, "decision body"),
        ]
        for mode, env, label in cases:
            with self.subTest(mode=mode, label=label):
                self.assert_failed(self.run_runner(mode, **env), f"{label}: HTTP transfer failed")

    def test_partial_whoami_response_cannot_supply_identity(self):
        result = self.run_runner("whoami", GRANT_NAMESPACE="app")
        self.assert_failed(result, "could not read the identity id from /sessions/whoami")

    def test_failed_registration_cannot_supply_cookie(self):
        for mode in ("registration-flow", "registration-submit"):
            with self.subTest(mode=mode):
                result = self.run_runner(mode, SESSION_COOKIE_VALUE="")
                self.assert_failed(result, "could not mint a Kratos session cookie")


if __name__ == "__main__":
    unittest.main(verbosity=2)

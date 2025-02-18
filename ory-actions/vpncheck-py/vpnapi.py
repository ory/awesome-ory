# Copyright © 2023 Ory Corp
# SPDX-License-Identifier: Apache-2.0

from flask import Flask, request, jsonify
import requests

import os

# load google cloud logging if running on GCP
if os.getenv('ENABLE_CLOUD_LOGGING', ''):
    # set up the Google Cloud Logging python client library
    import google.cloud.logging
    client = google.cloud.logging.Client()
    client.setup_logging()

# use Python’s standard logging library to send logs to GCP
import logging

app = Flask(__name__)

# Define the bearer token for authentication
BEARER_TOKEN = os.environ.get("BEARER_TOKEN")
VPNAPIIO_API_KEY = os.environ.get("VPNAPIIO_API_KEY")

if not BEARER_TOKEN or not VPNAPIIO_API_KEY:
    raise ValueError("BEARER_TOKEN or VPNAPIIO_API_KEY not set in environment variables.")

@app.route("/vpncheck", methods=["POST"])
def handle_vpncheck():
    return vpncheck(request)

def vpncheck(request):
    # Check for bearer token authentication
    auth_header = request.headers.get("Authorization")
    if not auth_header or not auth_header.startswith("Bearer "):
        return jsonify({"error": "Unauthorized"}), 401

    provided_token = auth_header.split("Bearer ")[1]
    if provided_token != BEARER_TOKEN:
        return jsonify({"error": "Unauthorized"}), 401

    # Parse the JSON payload and extract the IP address
    data = request.get_json()
    logging.info(f"request: {data}")
    ip_address = data.get("ip_address")
    if not ip_address:
        return error_response("Cannot determine Client IP address")

    # Call vpnapi.io to check the IP address
    # if the API fails, we permit by default
    try:
        vpn_result = query_vpn_io(ip_address)
    except Exception as e:
        return jsonify({"warning": "Unable to check VPN: ", "details": str(e)}), 200

    # Check the response from vpnapi.io
    if "error" in vpn_result and vpn_result["error"] == "Blocked":
        return error_response("Request blocked: Blocked by VPN API")

    if "security" in vpn_result:
        security_info = vpn_result["security"]
        if "vpn" in security_info and security_info["vpn"] == True:
            logging.info(f"vpn block: {security_info['vpn']}")
            return error_response("Request blocked: VPN")
        if "tor" in security_info and security_info["tor"] == True:
            logging.info(f"tor block: {security_info['tor']}")
            return error_response("Request blocked: Tor")

    if (
        "location" in vpn_result
        and "country_code" in vpn_result["location"]
        and vpn_result["location"]["country_code"] == "RU"
    ):
        logging.info(f"geoblock: {vpn_result['location']['country_code']}")
        return error_response("Request blocked: Geolocation")
    
    # Return the result as success or error details
    return jsonify(vpn_result), 200


def error_response(msg):
    return jsonify({"messages": [{ "messages": [{ "text": msg }] }]}), 400


def query_vpn_io(ip_address):
    # Implement the logic to call vpnapi.io and retrieve the result
    # You can use libraries like requests or httpx for making HTTP requests
    # Return the response as a dictionary
    # For example:

    url = f"https://vpnapi.io/api/{ip_address}?key={VPNAPIIO_API_KEY}"
    response = requests.get(url, timeout=1.5)
    if response.status_code != 200:
        raise Exception(f"vpnapi.io returned {response.status_code}")

    result = response.json()

    return result


if __name__ == "__main__":
    app.run()

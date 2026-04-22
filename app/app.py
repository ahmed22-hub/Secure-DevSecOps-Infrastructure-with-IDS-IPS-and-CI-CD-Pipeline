import os
from flask import Flask, jsonify, request

app = Flask(__name__)
PORT = os.getenv("PORT")
DEBUG = os.getenv("DEBUG")
ADMIN_USERNAME = os.getenv("ADMIN_USERNAME")
ADMIN_PASSWORD = os.getenv("ADMIN_PASSWORD")


if not PORT or not ADMIN_USERNAME or not ADMIN_PASSWORD:
    raise Exception("Missing environment variables!")

@app.route("/")
def home():
    return "Secure App Running 🚀"

@app.route("/health")
def health():
    return jsonify({"status": "OK"}), 200

@app.route("/login", methods=["POST"])
def login():
    data = request.json

    username = data.get("username")
    password = data.get("password")

    if username == ADMIN_USERNAME and password == ADMIN_PASSWORD:
        return jsonify({"message": "Login successful"})
    else:
        return jsonify({"message": "Invalid credentials"}), 401

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=int(PORT), debug=(DEBUG == "True"))


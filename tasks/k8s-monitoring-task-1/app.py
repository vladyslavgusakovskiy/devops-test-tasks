from flask import Flask
import os

app = Flask(__name__)

@app.route("/")
def hello():
    return "Hello from Kubernetes with Monitoring!"

@app.route("/ready")
def ready():
    return "Ready!", 200

@app.route("/health")
def health():
    return "Healthy!", 200

if __name__ == "__main__":
    app.run(host="0.0.0.0", port = int(os.getenv("APP_PORT", 8000)))
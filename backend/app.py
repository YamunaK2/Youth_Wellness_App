import os
import requests
from flask import Flask, request, jsonify
from flask_cors import CORS
from dotenv import load_dotenv

load_dotenv()

app = Flask(__name__)
CORS(app)

HF_API_KEY = os.getenv("HF_API_KEY")

API_URL = "https://api-inference.huggingface.co/models/google/flan-t5-small"
HEADERS = {"Authorization": f"Bearer {HF_API_KEY}"}

@app.route("/chat", methods=["POST", "GET"])
def chat():
    if request.method == "GET":
        return "Chat server running"

    user_message = request.json.get("message", "").strip()

    if not user_message:
        return jsonify({"reply": "Please say something 😊"}), 200

    response = requests.post(
        API_URL,
        headers=HEADERS,
        json={
            "inputs": f"Answer politely and helpfully: {user_message}"
        },
        timeout=60
    )

    if response.status_code == 200:
        data = response.json()
        if isinstance(data, list) and "generated_text" in data[0]:
            return jsonify({"reply": data[0]["generated_text"]}), 200
        return jsonify({"reply": "Hello 😊 How can I help you today?"}), 200

    if response.status_code == 503:
        return jsonify({"reply": "AI is waking up. Please send again 😊"}), 200

    return jsonify({"reply": "AI is busy. Try again shortly."}), 200


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000, debug=True)

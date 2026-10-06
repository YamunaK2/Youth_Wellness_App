import os

from flask import Flask, request, jsonify
from flask_cors import CORS
from dotenv import load_dotenv
from groq import Groq

load_dotenv()

app = Flask(__name__)
CORS(app)

GROQ_API_KEY = os.getenv("GROQ_API_KEY")

if not GROQ_API_KEY:
    raise RuntimeError("GROQ_API_KEY is missing from .env")

client = Groq(api_key=GROQ_API_KEY)


@app.route("/", methods=["GET"])
def home():
    return jsonify({
        "message": "Youth Wellness AI Backend is running"
    })


@app.route("/chat", methods=["GET", "POST"])
def chat():

    if request.method == "GET":
        return jsonify({
            "message": "Chat server running"
        })

    try:
        data = request.get_json(silent=True) or {}

        user_message = data.get("message", "").strip()

        if not user_message:
            return jsonify({
                "reply": "Please say something 😊"
            }), 200

        completion = client.chat.completions.create(
            model="openai/gpt-oss-20b",

            messages=[
                {
                    "role": "system",
                    "content": (
                        "You are Youth Wellness Companion, "
                        "a friendly and supportive wellness assistant "
                        "for young people. "
                        "Respond with empathy and encouragement. "
                        "Keep responses clear and reasonably concise. "
                        "You are not a doctor or psychologist and should "
                        "not claim to provide professional diagnosis."
                    )
                },
                {
                    "role": "user",
                    "content": user_message
                }
            ],

            temperature=0.7,
            max_tokens=500,
        )

        reply = completion.choices[0].message.content

        return jsonify({
            "reply": reply
        }), 200

    except Exception as e:

        print("Groq Error:", e)

        return jsonify({
            "reply": "I'm having trouble connecting right now. Please try again 😊"
        }), 500


if __name__ == "__main__":
    app.run(
        host="0.0.0.0",
        port=int(os.environ.get("PORT", 5000)),
        debug=False
    )
import platform

from flask import Flask, jsonify

app = Flask(__name__)


@app.route("/")
def index():
    return jsonify(
        message="API de gestion des produits - en ligne",
        python=platform.python_version(),
    )


@app.route("/health")
def health():
    return jsonify(status="ok"), 200


if __name__ == "__main__":
    # 0.0.0.0 : indispensable pour que l'app soit joignable depuis l'extérieur du conteneur
    app.run(host="0.0.0.0", port=5000)
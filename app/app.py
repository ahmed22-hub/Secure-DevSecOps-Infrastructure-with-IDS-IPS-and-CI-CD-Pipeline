from flask import Flask, jsonify, request

app = Flask(__name__)

@app.route("/")
def home():
    return """
    <h1>Secure DevSecOps Demo App</h1>
    <p>Application minimale pour le projet PFA.</p>
    <p>Routes disponibles:</p>
    <ul>
        <li><a href="/health">/health</a></li>
        <li><a href="/login">/login</a></li>
    </ul>
    """

@app.route("/health")
def health():
    return jsonify({
        "status": "ok",
        "service": "demo-app"
    }), 200

@app.route("/login", methods=["GET", "POST"])
def login():
    if request.method == "POST":
        username = request.form.get("username", "")
        return f"<h2>Bienvenue {username}</h2><p>Login demo reussi.</p>"
    
    return """
    <h1>Demo Login Page</h1>
    <form method="post">
        <label>Username:</label><br>
        <input type="text" name="username"><br><br>
        <label>Password:</label><br>
        <input type="password" name="password"><br><br>
        <button type="submit">Login</button>
    </form>
    """

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000, debug=True)

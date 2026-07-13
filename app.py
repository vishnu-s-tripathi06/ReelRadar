from flask import Flask, render_template, redirect, request, url_for

app = Flask(__name__)

@app.route("/greet", methods=["POST","GET"])
def greet():
    name = request.form.get("name")
    password = request.form.get("password")

    if name and password:
        return redirect(url_for("home"))   # function name, not route string
    else:
        return redirect(url_for("signup"))

@app.route("/index")
def home():
    return "Welcome to the Home Page!"

@app.route("/signup")
def signup():
    return "Please sign up here."

if __name__ == "__main__":
    app.run(debug=True)

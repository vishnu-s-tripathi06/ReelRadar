from flask import Flask,render_template,redirect,request

app=Flask(__name__)
@app.route("/")
def index():
    name=request.args.get("name","world!")
    return render_template("index.html")

@app.route("/greet")
def greet():
    return render_template("greet.html",name=request.args.get("Name","World!"))


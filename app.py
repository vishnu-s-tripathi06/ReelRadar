from flask import Flask, render_template, request

app = Flask(__name__)

@app.route("/",methods=['GET','POST'])
def index():
        name=request.form.get("name","world")
        return render_template("html/index.html",name=name)


@app.route("/home", methods=['GET', 'POST'])
def home():
    if request.method == 'POST':
        userid = request.form.get("userid", "world")
        action = request.form.get("action")  # "login" or "register"
        if action=="register":
             return render_template("html/register.html")
   

        return render_template("html/home.html", name=userid, action=action)

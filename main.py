from flask import Flask, render_template, request, session, redirect
from flask_sqlalchemy import SQLAlchemy
from flask_mail import Mail, Message
import json
from datetime import datetime
import os
from werkzeug.utils import secure_filename
import math


# Gettings params from config.json
with open('config.json', 'r') as c:
    params = json.load(c)["params"]

# Boolean to switch database url from config.json
local_server = True

# Flask app initialization
app = Flask(__name__)

# Setting app secret key
app.secret_key = "super-secret-key"

# Setting app default upload folder location
app.config['UPLOAD_FOLDER'] = params['upload_location']

# Passing datetime object in every template using a context processor
@app.context_processor
def inject_now():
    return {'date_now': datetime.utcnow()}

# Email sending configuration
app.config.update(
    MAIL_SERVER = 'smtp.gmail.com',
    MAIL_PORT = '465',
    MAIL_USE_SSL = True,
    MAIL_USERNAME = params['gmail-user'],
    MAIL_PASSWORD=  params['gmail-password']
)
mail = Mail(app)

# Connecting MySQL Database 
if(local_server):
    app.config['SQLALCHEMY_DATABASE_URI'] = params['local_uri']
else:
    app.config['SQLALCHEMY_DATABASE_URI'] = params['prod_uri']
    
    
# Database Connection
db = SQLAlchemy(app)

# Contacts table import from mysql
class Contacts(db.Model):
    sno = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(80), nullable=False)
    phone_num = db.Column(db.String(12), nullable=False)
    msg = db.Column(db.String(120), nullable=False)
    date = db.Column(db.String(12), nullable=True)
    email = db.Column(db.String(20), nullable=False)

# Posts table import from mysql
class Posts(db.Model):
    sno = db.Column(db.Integer, primary_key=True)
    title = db.Column(db.String(80), nullable=False)
    slug = db.Column(db.String(21), nullable=False)
    content = db.Column(db.String(120), nullable=False)
    date = db.Column(db.String(12), nullable=True)
    img_file = db.Column(db.String(12), nullable=True)
    tagline = db.Column(db.String(12), nullable=True)
    
# Creating a Function to handle forgot Username/Password
def send_username_password():
    message = f'''
    Your account details are:
    Username: {params["admin_username"]}   
    Password: {params["admin_password"]}'''
                                     
    msg = Message('Admin Login Details for {}'.format(params["blog_special_name"]), recipients=[params["gmail-user"]], sender=params["gmail-user"])
    msg.html = 'Your admin panel login details for {} are as follows: <br><br> <strong>Username:</strong> {} <br> <strong>Password:</strong> {}'.format(params["blog_special_name"], params["admin_username"], params["admin_password"])
    mail.send(msg)

# Home page render
@app.route("/")
def home():
    # Fetching Posts from Database
    posts = Posts.query.filter_by().all()
    if params['no_of_posts'] == 0:
        last = 1
    else:
        last = math.ceil(len(posts)/int(params['no_of_posts']))
    page = request.args.get('page')
    if (not str(page).isnumeric()):
        page = 1
    page = int(page)
    posts = posts[(page-1)*int(params['no_of_posts']):(page-1)*int(params['no_of_posts'])+ int(params['no_of_posts'])]
    
    if params['no_of_posts'] == 0:
        posts = []
    
    # If first page is the only page(Then first is also the last page)
    if page==1==last:
        prev = "#"
        next = "#"
    # If first page
    elif page==1:
        prev = "#"
        next = "/?page="+ str(page+1)
    # If last page
    elif page==last:
        prev = "/?page="+ str(page-1)
        next = "#"
    # Middle Pages
    else:
        prev = "/?page="+ str(page-1)
        next = "/?page="+ str(page+1)
    
    return render_template('index.html', params=params, posts=posts, prev=prev, next=next)


# Post page render
@app.route("/post/<string:post_slug>", methods=['GET'])
def post(post_slug):
    post = Posts.query.filter_by(slug=post_slug).first()
    return render_template('post.html', params=params, post=post)

# About page render
@app.route("/about")
def about():
    return render_template('about.html', params=params)

# Contact page render
@app.route("/contact", methods = ['GET', 'POST'])
def contact():
    
    if(request.method=='POST'):
        name = request.form.get('name')
        email = request.form.get('email')
        phone = request.form.get('phone')
        message = request.form.get('message')
        entry = Contacts(name=name, phone_num = phone, msg = message, date= datetime.now(),email = email )
        db.session.add(entry)
        db.session.commit()
        mail.send_message('New message from ' + name,
                          sender=email,
                          recipients = [params['gmail-user']],
                          body = message + "\n" + phone
                          )
    return render_template('contact.html', params=params)

# Dashboard page render
@app.route("/dashboard", methods = ['GET', 'POST'])
def dashboard():
    # Handling forgot Username/Password
    if request.method == "GET" and request.args.get("forgot")=="true":
        send_username_password()
        return render_template('login.html', params=params, forgot=True)
         
    # Handling Delete Alert
    if request.method == "GET" and "user" in session and session["user"] == params["admin_username"]:
        deleted = request.args.get('del')
        title = request.args.get('title')
        print(deleted,title)
        posts = Posts.query.all()
        if deleted == "success" and title is not None:
                    return render_template("dashboard.html", params=params, posts=posts, deleted={"deleted": True, "title":title})
        
    # If user already logged in
    if ("user" in session and session["user"] == params["admin_username"]):
        posts = Posts.query.all()
        return render_template("dashboard.html", params=params, posts=posts)
    
    # Handling Login
    if request.method == "POST":
        username = request.form.get("username")
        password = request.form.get("password")
        print(username, password)
        # Checking Login Credentials
        if username == params['admin_username'] and password == params['admin_password']:
            # Set session variable
            session["user"] = username        
            posts = Posts.query.all()
            # Render Admin Panel
            return render_template("dashboard.html", params=params, posts=posts)
        else:
            # Render Login Page with incorrect details alert
            return render_template("login.html", params=params, incorrect=True)

            
    # Otherwise prompt for login
    return render_template('login.html', params=params)

# Edit page render
@app.route("/edit/<string:sno>", methods=['GET', 'POST'])
def edit(sno):
    # Will only allow if the user is logged in
    if ("user" in session and session["user"] == params["admin_username"]):
        # We will add a post if the sno. is 0 else we will edit the post
        # We will do nothing on a GET request, the data will only be manipulated if it is a POST request
        if request.method == 'POST':
            title = request.form.get("title")
            title = request.form.get("title")
            tagline = request.form.get("tagline")
            slug = request.form.get("slug")
            img_file = request.form.get("img_file")
            content = request.form.get("content")
            date = datetime.now()

            if sno=='0':
                        post = Posts(title=title, slug=slug, content=content, tagline=tagline, img_file=img_file, date=date)
                        db.session.add(post)
                        db.session.commit()
            else:
                post = Posts.query.filter_by(sno=sno).first()
                post.title = title
                post.tagline = tagline
                post.slug = slug
                post.content = content
                post.img_file = img_file
                post.date = post.date
                db.session.commit()
                return redirect('/edit/'+sno)
            
        post = Posts.query.filter_by(sno=sno).first()    
        return render_template("edit.html", params=params, post=post, sno=sno)
    
# Handling File Upload
@app.route("/uploader", methods=['GET', 'POST'])
def uploader():
    if "user" in session and session['user']==params['admin_username']:
        if request.method=='POST':
            f = request.files['file']
            timestamp = datetime.now()
            f.save(os.path.join(app.config['UPLOAD_FOLDER'], secure_filename(f"{timestamp}_{f.filename}")))
            return "Uploaded successfully!"

# Handling Logout
@app.route('/logout')
def logout():
    session.pop('user')
    return redirect('/dashboard')

# Handling Post Delete
@app.route("/delete/<string:sno>" , methods=['GET', 'POST'])
def delete(sno):
    if "user" in session and session['user']==params['admin_username']:
        post = Posts.query.filter_by(sno=sno).first()
        db.session.delete(post)
        db.session.commit()
        return redirect(f"/dashboard?del=success&title={post.title}")
    return redirect("/dashboard")


    

app.run(debug=True)


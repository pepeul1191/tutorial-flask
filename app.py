#!/usr/bin/env python
# -*- coding: utf-8 -*-

from flask import Flask, request, render_template, session
from datetime import datetime

APP = Flask(
    __name__,
    static_folder='static',
    static_url_path='/',
    template_folder='templates', 
)

APP.config['SESSION_TYPE'] = 'filesystem'
APP.secret_key = 'mysercretkey'

@APP.route('/')
def home():
    # return 'Hello, World?', 400
    return render_template('home.html'), 200

@APP.route('/demo_path/<name>/<int:age>', methods=['GET'])
def demo_path(name, age):
    print('path parameter -> nombre : %s, edad : %d' % (name, age))
    return 'path parameter -> nombre : %s, edad : %d' % (name, age), 200

@APP.route('/demo_query', methods=['GET'])
def demo_query():
    name = request.args.get('name')
    age = int(request.args.get('age'))
    print('query parameter -> nombre : %s, edad : %d' % (name, age))
    return 'query parameter -> nombre : %s, edad : %d' % (name, age), 200

@APP.route('/home')
def home_view():
    locals = {
        'nombre': 'Pepe',
        'edad': 32,
        'title': 'Home 1',
        'bicicletas': [
            {
                'img': 'ticla01',
                'alt': 'K036',
            },
            {
                'img': 'ticla02',
                'alt': 'Tempo01',
            },
        ],
    }
    return render_template(
        'demo.html', 
        locals=locals,
    ), 200

@APP.route('/home2')
def home_view2():
    locals = {
        'mascota': 'Sila',
    }
    return render_template(
        'demo2.html', 
        locals=locals,
    ), 200

@APP.route('/demo_post', methods=['POST'])
def demo_post():
    name = request.form['name']
    age = int(request.form['age'])
    print(request.method)
    print('post parameter -> nombre : %s, edad : %d' % (name, age))
    return 'post parameter -> nombre : %s, edad : %d' % (name, age), 200

@APP.route('/login', methods=['GET'])
def login():
    locals = {
        'message': '',
    }
    return render_template(
        'login.html',
        locals=locals
    ), 200

@APP.route('/login', methods=['POST'])
def login_access():
    user = request.form['user']
    password = request.form['password']
    if user == 'root' and password == '123':
        session['status'] = 'active'
        session['user'] = 'root'
        session['time'] = datetime.now()
        print(session)
        return render_template('home.html'), 200
    else:
        locals = {
            'message': 'Usuario y contraseña no coinciden',
        }
        return render_template(
            'login.html',
            locals=locals
        ), 500

@APP.route('/logout', methods=['GET'])
def logout():
    session.clear()
    locals = {
        'message': '',
    }
    return render_template(
        'login.html',
        locals=locals
    ), 200

if __name__ == '__main__':
    APP.run(
        debug=True, 
    )

#!/usr/bin/env python
# -*- coding: utf-8 -*-

from flask import Flask, request, render_template, session, redirect
from functools import wraps
from datetime import datetime

# database config

# models

# application constants

CONSTANTS = {
    'secret_key': 'mysercretkey',
    'base_ulr': 'http://localhost:3000/',
    'static_url': 'http://localhost:3000/',
}

# helpers

def load_css(csss):
    rpta = ''
    if len(csss) > 0:
        for css in csss:
            temp = ('<link href="'
                    + CONSTANTS['static_url']
                    + css
                    + '.css" rel="stylesheet"/>')
            rpta = rpta + temp
    return rpta


def load_js(jss):
    rpta = ''
    if len(jss) > 0:
        for js in jss:
            temp = ('<script src="'
                    + CONSTANTS['static_url']
                    + js
                    + '.js" type="text/javascript"></script>')
            rpta = rpta + temp
    return rpta

# middlewares

def not_found(e):
    print(request.url)
    if request.method == 'GET':
        return render_template(
                '404.html', 
            ), 404
    else:
        return 'Recurso no encontrado', 404

def if_session_not_active_go_login(param):
    def decorator(fn):
        @wraps(fn)
        def wrapper(*args, **kwargs):         
            # print(param)
            if session.get('status') is not None:
                if session.get('status') != 'active':
                    return redirect('/login')
            else:
                return redirect('/login')
            return fn(*args, **kwargs)
        return wrapper
    return decorator

def if_session_active_go_home():
    def decorator(fn):
        @wraps(fn)
        def wrapper(*args, **kwargs):
            if session.get('status') is not None:
                if session.get('status') == 'active':
                    return redirect('/')
            return fn(*args, **kwargs)
        return wrapper
    return decorator

# application config

APP = Flask(
    __name__,
    static_folder='static',
    static_url_path='/',
    template_folder='templates', 
)

APP.config['SESSION_TYPE'] = 'filesystem'
APP.secret_key = CONSTANTS['secret_key']
APP.register_error_handler(404, not_found)
APP.register_error_handler(405, not_found)

# end-points

@APP.context_processor
def utility_processor():
    return dict(
        load_css=load_css,
        load_js=load_js,
        constants=CONSTANTS,
    )

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
@if_session_active_go_home()
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
        # return render_template('home.html'), 200
        return redirect('/')
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
    return redirect('/')

@APP.route('/admin', methods=['GET'])
@if_session_not_active_go_login(param='pepe')
def admin():
    locals = {
        'title': 'Admin Dashboard',
        'csss': ['assets/css/demo', 'assets/css/demo2'],
        'jss': ['assets/js/lib', 'assets/js/demo'],
    }
    return render_template(
        'admin.html',
        locals=locals
    ), 200

# main function

if __name__ == '__main__':
    APP.run(
        debug=True, 
    )

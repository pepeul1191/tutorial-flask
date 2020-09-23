# !/usr/bin/env python
# -*- coding: utf-8 -*-

from flask import Flask, request, render_template, session, redirect
from functools import wraps
from datetime import datetime
from sqlalchemy import select
import json

from main.constants import CONSTANTS
from main.models import Country
from main.database import engine
from main.filters import not_found, if_session_not_active_go_login, if_session_active_go_home
from main.helpers import load_css, load_js

APP = Flask(
    __name__,
    static_folder='../static',
    static_url_path='/',
    template_folder='../templates', 
)

APP.config['SESSION_TYPE'] = 'filesystem'
APP.secret_key = 'mysercretkey'
APP.register_error_handler(404, not_found)
APP.register_error_handler(405, not_found)

@APP.context_processor
def utility_processor():
    return dict(
        load_css=load_css,
        load_js=load_js,
        constants=CONSTANTS,
    )

@APP.route('/', methods=['GET'])
def home():
    locals={ }
    return render_template(
        'home.html',
        locals=locals
        ), 200

@APP.route('/admin', methods=['GET'])
@if_session_not_active_go_login(param='pepe')
def admin():
    locals={ 
        'csss': ['assets/css/demo', 'assets/css/demo2'],
        'jss': ['assets/js/lib', 'assets/js/demo'],
    }
    return render_template(
        'admin.html',
        locals=locals
        ), 200

@APP.route('/login', methods=['GET'])
@if_session_active_go_home()
def login():
    locals={
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
        # crear session
        session['status'] = 'active'
        session['user'] = 'root'
        session['time'] = datetime.now()
        locals={}
        print(session)
        return redirect('/')
    else:
        locals={
            'message': 'El usuario y/o no existen',
        }
        print(session)
        return render_template(
            'login.html',
            locals=locals
            ), 500

@APP.route('/logout', methods=['GET'])
def logout():
    session.clear()
    locals={
        'message': 'Su sesión ha sido destruida',
    }
    return redirect('/login')

@APP.route('/demo', methods=['GET'])
def demo():
    return 'hola demo', 200

@APP.route('/home', methods=['GET'])
def home_view():
    locals={
        'title': 'Hola Demo',
        'edad': 27,
        'bicicletas': [
            {
                'img': 'cici01',
                'alt': 'K036',
            },
            {
                'img': 'cici02',
                'alt': 'Tempo01',
            },
        ],
    }
    return render_template(
        'demo.html', 
        locals=locals, 
        title='Titulo de Home'
        ), 200

@APP.route('/home2', methods=['GET'])
def home_view2():
    locals={
        'title': 'Hola Demo',
        'edad': 27,
        'bicicletas': [
            {
                'img': 'cici01',
                'alt': 'K036',
            },
            {
                'img': 'cici02',
                'alt': 'Tempo01',
            },
        ],
    }
    return render_template(
        'demo2.html', 
        locals=locals, 
        title='Titulo de Home'
        ), 200

@APP.route('/demo_path/<name>/<int:age>', methods=['GET'])
def demo_path(name, age):
    print('path parameter -> nombre : %s, edad : %d' % (name, age))
    return 'path parameter -> nombre : %s, edad : %d' % (name, age), 200

@APP.route('/demo_query', methods=['GET'])
def demo_query():
    name = request.args.get('name')
    age = int(request.args.get('age'))
    print('path parameter -> nombre : %s, edad : %d' % (name, age))
    return 'path parameter -> nombre : %s, edad : %d' % (name, age), 200

@APP.route('/demo_post', methods=['POST'])
def demo_post():
    name = request.form['name']
    age = int(request.form['age'])
    print('path parameter -> nombre : %s, edad : %d' % (name, age))
    return 'path parameter -> nombre : %s, edad : %d' % (name, age), 404

@APP.route('/country/list')
def country_list():
    resp = None
    status = 200
    try:
        conn = engine.connect()
        stmt = select([Country])
        rs = conn.execute(stmt)
        resp = [dict(r) for r in conn.execute(stmt)]
    except Exception as e:
        resp = [
            'Se ha producido un error en listar los paises',
            str(e)
        ]
        status = 500
    return json.dumps(resp), status
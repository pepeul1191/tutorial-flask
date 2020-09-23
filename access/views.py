#!/usr/bin/env python
# -*- coding: utf-8 -*-

from flask import Blueprint, render_template, session, request, redirect
from datetime import datetime
from main.filters import if_session_active_go_home, if_session_not_active_go_login

view = Blueprint('access_bludprint', __name__)

@view.route('/login', methods=['GET'])
@if_session_active_go_home()
def login():
    locals={
        'message': '',
    }
    return render_template(
        'login.html',
        locals=locals
        ), 200

@view.route('/login', methods=['POST'])
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

@view.route('/logout', methods=['GET'])
def logout():
    session.clear()
    locals={
        'message': 'Su sesión ha sido destruida',
    }
    return redirect('/login')

@view.route('/', methods=['GET'])
def home():
    locals={ }
    return render_template(
        'home.html',
        locals=locals
        ), 200

@view.route('/admin', methods=['GET'])
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
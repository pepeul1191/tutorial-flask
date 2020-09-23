# !/usr/bin/env python
# -*- coding: utf-8 -*-

from flask import request, render_template, session, redirect
from functools import wraps

def not_found(e):
    locals = {}
    if request.method == 'GET':
        return render_template(
            '404.html',
            locals=locals
            ), 200
    else:
        return 'Recurso no encontraado', 404

def if_session_not_active_go_login(param):
    def decorator(fn):
        @wraps(fn)
        def wrapper(*args, **kwargs):         
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
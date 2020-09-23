#!/usr/bin/env python
# -*- coding: utf-8 -*-

from flask import Blueprint, render_template, session, request, redirect

view = Blueprint('access_demo_bludprint', __name__)

@view.route('/demo', methods=['GET'])
def demo():
    return 'hola demo', 200

@view.route('/home', methods=['GET'])
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

@view.route('/home2', methods=['GET'])
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

@view.route('/demo_path/<name>/<int:age>', methods=['GET'])
def demo_path(name, age):
    print('path parameter -> nombre : %s, edad : %d' % (name, age))
    return 'path parameter -> nombre : %s, edad : %d' % (name, age), 200

@view.route('/demo_query', methods=['GET'])
def demo_query():
    name = request.args.get('name')
    age = int(request.args.get('age'))
    print('path parameter -> nombre : %s, edad : %d' % (name, age))
    return 'path parameter -> nombre : %s, edad : %d' % (name, age), 200

@view.route('/demo_post', methods=['POST'])
def demo_post():
    name = request.form['name']
    age = int(request.form['age'])
    print('path parameter -> nombre : %s, edad : %d' % (name, age))
    return 'path parameter -> nombre : %s, edad : %d' % (name, age), 404
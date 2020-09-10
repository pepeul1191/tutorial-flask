#!/usr/bin/env python
# -*- coding: utf-8 -*-

from flask import Flask, request, render_template

APP = Flask(
    __name__,
    static_folder='static',
    static_url_path='/',
    template_folder='templates', 
)

@APP.route('/')
def home():
    return 'Hello, World?', 400

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
    return render_template('demo.html'), 200

@APP.route('/demo_post', methods=['POST'])
def demo_post():
    name = request.form['name']
    age = int(request.form['age'])
    print(request.method)
    print('post parameter -> nombre : %s, edad : %d' % (name, age))
    return 'post parameter -> nombre : %s, edad : %d' % (name, age), 200

if __name__ == '__main__':
    APP.run(
        debug=True, 
    )

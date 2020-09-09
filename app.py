#!/usr/bin/env python
# -*- coding: utf-8 -*-

from flask import Flask, request

APP = Flask(
  __name__,
  static_folder='static',
  static_url_path='/',
)

@APP.route('/')
def home():
    return 'Hello, World?'

@APP.route('/demo_path/<name>/<int:age>')
def demo_path(name, age):
    print('path parameter -> nombre : %s, edad : %d' % (name, age))
    return 'path parameter -> nombre : %s, edad : %d' % (name, age)

@APP.route('/demo_query')
def demo_query():
    name = request.args.get('name')
    age = int(request.args.get('age'))
    print('query parameter -> nombre : %s, edad : %d' % (name, age))
    return 'query parameter -> nombre : %s, edad : %d' % (name, age)

if __name__ == '__main__':
    APP.run(
        debug=True, 
    )

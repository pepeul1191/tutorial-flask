# !/usr/bin/env python
# -*- coding: utf-8 -*-

from flask import Flask, request, render_template, session, redirect
from main.constants import CONSTANTS
from main.filters import not_found
from main.helpers import load_css, load_js
from main.blueprints import register

# create APP
APP = Flask(
    __name__,
    static_folder='../static',
    static_url_path='/',
    template_folder='../templates', 
)
# config APP
APP.config['SESSION_TYPE'] = 'filesystem'
APP.secret_key = 'mysercretkey'
APP.register_error_handler(404, not_found)
APP.register_error_handler(405, not_found)
# register blueprints
register(APP)
# load helpers
@APP.context_processor
def utility_processor():
    return dict(
        load_css=load_css,
        load_js=load_js,
        constants=CONSTANTS,
    )


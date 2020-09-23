#!/usr/bin/env python
# -*- coding: utf-8 -*-

import json
from flask import Blueprint, render_template, session, request, redirect
from main.models import Country
from main.database import engine
from sqlalchemy import select

view = Blueprint('admin_bludprint', __name__)

@view.route('/country/list')
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
# !/usr/bin/env python
# -*- coding: utf-8 -*-

from main.constants import CONSTANTS

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
# !/usr/bin/env python
# -*- coding: utf-8 -*-

from sqlalchemy import Column, Integer, String
from main.database import Base

class Country(Base):
    __tablename__ = 'countries'
    id = Column(Integer, primary_key=True)
    name = Column(String)

class Carrer(Base):
    __tablename__ = 'carrers'
    id = Column(Integer, primary_key=True)
    name = Column(String)
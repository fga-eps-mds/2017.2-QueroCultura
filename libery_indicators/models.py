from django.db import models
from mongoengine import *

class PercentLiberyForState(Document):
    _totalLiberyForState = MapField(required = True)
    _totalLibery = IntField(required = True)

    @property
    def totalLiberyForState(self):
        return self._totalLiberyForState

    @totalLiberyForState.setter
    def totalLiberyForState(self, number):
        self._totalLiberyForState = number

    @property
    def totalLibery(self):
        return self._totalLibery

    @totalLibery.setter
    def totalLibery(self, number):
        self._totalLibery = number

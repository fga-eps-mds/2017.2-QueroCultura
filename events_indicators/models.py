# from django.db import models
from mongoengine import Document
from mongoengine import MapField


class PercentTypeEventsForState(Document):
    _typeStateEvents = MapField(required=True)
    _totalStateEvents = MapField(required=True)

    @property
    def typeStateEvents(self):
        return self._typeStateEvents

    @typeStateEvents.setter
    def typeStateEvents(self, number):
        self._typeStateEvents = number

    @property
    def totalStateEvents(self):
        return self._totalStateEvents

    @totalStateEvents.setter
    def totalStateEvents(self, number):
        self._totalStateEvents = number

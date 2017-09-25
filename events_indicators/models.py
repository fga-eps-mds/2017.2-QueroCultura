from django.db import models
from mongoengine import *


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


class PercentEventsForSpace(Document):
    _typeSpaceEvents = MapField(required=True)
    _totalSpaceEvents = MapField(required=True)

    @property
    def typeSpaceEvents(self):
        return self._typeStateEvents

    @typeSpaceEvents.setter
    def typeStateEvents(self, number):
        self._typeStateEvents = number

    @property
    def totalSpaceEvents(self):
        return self._totalStateEvents

    @totalSpaceEvents.setter
    def totalStateEvents(self, number):
        self._totalStateEvents = number

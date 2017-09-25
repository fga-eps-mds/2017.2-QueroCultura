from django.db import models
from mongoengine import *


class PercentLiberyForState(Document):
    _totalLiberyForState = MapField(required=True)
    _totalLibery = IntField(required=True)

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


class PercentLiberyPerAreaOfActivityPerState(Document):
    _totalLiberyPerAreaOfActivityPerState = MapField(required=True)
    _totalLiberyPerState = MapField(required=True)

    @property
    def totalLiberyPerAreaOfActivityPerState(self):
        return self._totalLiberyPerAreaOfActivityPerState

    @totalLiberyPerAreaOfActivityPerState.setter
    def totalLiberyPerAreaOfActivityPerState(self, number):
        self._totalLiberyPerAreaOfActivityPerState = number

    @property
    def totalLiberyPerState(self):
        return self._totalLiberyPerState

    @totalLiberyPerState.setter
    def totalLiberyPerState(self, number):
        self._totalLiberyPerState = number


class PercentLiberyPerAreaOfActivity(Document):
    _totalLiberyPerAreaOfActivity = MapField(required=True)
    _totalLibery = IntField(required=True)

    @property
    def totalLiberyPerAreaOfActivity(self):
        return self._totalLiberyPerAreaOfActivity

    @totalLiberyPerAreaOfActivity.setter
    def totalLiberyPerAreaOfActivity(self, number):
        self._totalLiberyPerAreaOfActivity = number

    @property
    def totalLibery(self):
        return self._totalLibery

    @totalLibery.setter
    def totalLibery(self, number):
        self._totalLibery = number


class PercentLiberyPerSpherePerState(Document):
    _totalLiberyPerSpherePerState = MapField(required=True)
    _totalLiberyPerState = MapField(required=True)

    @property
    def totalLiberyPerSpherePerState(self):
        return self._totalLiberyPerSpherePerState

    @totalLiberyPerSpherePerState.setter
    def totalLiberyPerSpherePerState(self, number):
        self._totalLiberyPerSpherePerState = number

    @property
    def totalLiberyPerState(self):
        return self._totalLibery

    @totalLiberyPerState.setter
    def totalLiberyPerState(self, number):
        self._totalLiberyPerState = number


class PercentLiberyPerSphere(Document):
    _totalLiberyPerSphere = MapField(required=True)
    _totalLibery = MapField(required=True)

    @property
    def totalLiberyPerSphere(self):
        return self._totalLiberyPerSphere

    @totalLiberyPerSphere.setter
    def totalLiberyPerSphere(self, number):
        self._totalLiberyPerSphere = number

    @property
    def totalLibery(self):
        return self._totalLibery

    @totalLibery.setter
    def totalLibery(self, number):
        self._totalLibery = number

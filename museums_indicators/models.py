from django.db import models
from mongoengine import *

class PercentThematicsMuseumsForState(Document):
    _thematicsMuseumsForState = MapField(required = True)
    _totalMuseumsForState = MapField(requiered = True)

    @property
    def thmeaticsMuseumsForState(self):
        return self._thematicsMuseumsForState

    @thmeaticsMuseumsForState.setter
    def thmeaticsMuseumsForState(self, number):
        self._thematicsMuseumsForState = number

    @property
    def totalMuseumsForState(self):
        return self._totalMuseumsForState

    @totalMuseumsForState.setter
    def totalMuseumsForState(self, number):
        self._totalMuseumsForState = number


class PercentTypeMuseumsForState(Document):
    _typeMuseumsForState = MapField(required = True)
    _totalMuseumsForState = MapField(required = True)

    @property
    def typeMuseumsForState(self):
        return self._typeMuseumsForState

    @typeMuseumsForState.setter
    def typeMuseumsForState(self, number):
        self._typeMuseumsForState = number

    @property
    def totalMuseumsForState(self):
        return self._totalMuseumsForState

    @totalMuseumsForState.setter
    def totalMuseumsForState(self, number):
        self._totalMuseumsForState = number


class PercentPublicOrPrivateMuseums(Document):
    _totalPublicMuseums = IntField(required = True)
    _totalPrivateMuseums = IntField(required = True)
    _totalMuseums = IntField(required = True)

    @property
    def totalPublicMuseums(self):
        return self._totalPublicMuseums

    @totalPublicMuseums.setter
    def totalPublicMuseums(self, number):
        self._totalPublicMuseums = number

    @property
    def totalPrivateMuseums(self):
        return self._totalPrivateMuseums

    @totalPrivateMuseums.setter
    def totalPrivateMuseums(self, number):
        self._totalPrivateMuseums = number

    @property
    def totalMuseums(self):
        return self._totalMuseums

    @totalMuseums.setter
    def totalMuseums(self, number):
        self._totalMuseums = number


class PercentMuseumsForState(Document):
    _totalMuseumsForState = MapField(required = True)
    _totalMuseums = IntField(required = True)

    @property
    def totalMuseumsForState(self):
        return self._totalMuseumsForState

    @totalMuseumsForState.setter
    def totalMuseumsForState(self, number):
        self._totalMuseumsForState = number

    @property
    def totalMuseums(self):
        return self._totalMuseums

    @totalMuseums.setter
    def totalMuseums(self, number):
        self._totalMuseums = number

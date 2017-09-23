from django.db import models
from mongoengine import *

class PercentThematicsMuseumsForState:
    _thematicsMuseumsForState = MapField(required = True)
    _totalMuseumsForState = MapField(requiered = True)

    @property
    def thmeaticsMuseumsForState(self):
        return self._thematicsMuseumsForState

    @thmeaticsMuseumsForState.setter
    def thmeaticsMuseumsForState(self,number):
        self._thematicsMuseumsForState = number

    @property
    def totalMuseumsForState(self):
        return self._totalMuseumsForState

    @totalMuseumsForState.setter
    def totalMuseumsForState(self,number):
        self._totalMuseumsForState = number

class PercentTypeMuseumsForState:
    _typeMuseumsForState = MapField(required = True)
    _totalMuseumsForState = MapField(required = True)

    @property
    def typeMuseumsForState(self):
        return self._typeMuseumsForState

    @typeMuseumsForState.setter
    def typeMuseumsForState(self,number):
        self._typeMuseumsForState = number

    @property
    def totalMuseumsForState(self):
        return self._totalMuseumsForState

    @totalMuseumsForState.setter
    def totalMuseumsForState(self,number):
        self._totalMuseumsForState = number


class PercentPublicOrPrivateMuseums:
    _totalPublicMuseums = IntField(required = True)
    _totalPrivateMuseums = IntField(required = True)
    _totalMuseums = IntField(required = True)

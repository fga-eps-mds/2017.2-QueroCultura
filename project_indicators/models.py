# from django.db import models
from mongoengine import Document
from mongoengine import MapField
from mongoengine import IntField
from mongoengine import StringField

# --------------------- national indicators ----------------------------------


class PercentProjectPerType(Document):
    _totalProject = IntField(required=True)
    _totaProjectPerType = MapField(required=True)
    _createDate = StringField(required=True)

    @property
    def totalProject(self):
        return self._totalProject

    @totalProject.setter
    def totalProject(self, number):
        self._totalProject = number

    @property
    def totalProjectPerType(self):
        return self._totalProjectPerType

    @totalProjectPerType.setter
    def totalProjectPerType(self, number):
        self._totalProjectPerType = number

    @property
    def createDate(self):
        return self._createDate

    @createDate.setter
    def createDate(self, number):
        self._createDate = number


class PercentProjectThatAcceptOnlineTransitions(Document):
    _totalProjectThatAcceptOnlineTransitions = IntField(required=True)
    _totalProject = IntField(required=True)
    _createDate = StringField(required=True)

    @property
    def totalProject(self):
        return self._totalProject

    @totalProject.setter
    def totalProject(self, number):
        self._totalProject = number

    @property
    def totalProjectThatAcceptOnlineTransitions(self):
        return self._totalProjectThatAcceptOnlineTransitions

    @totalProjectThatAcceptOnlineTransitions.setter
    def totalProjectThatAcceptOnlineTransitions(self, number):
        self._totalProjectThatAcceptOnlineTransitions = number

    @property
    def createDate(self):
        return self._createDate

    @createDate.setter
    def createDate(self, number):
        self._createDate = number

# -------------------- state indicators --------------------------------------


class PercentProjectPerTypePerState(Document):
    _totalProjectPerState = MapField(required=True)
    _totaProjectPerTypePerState = MapField(required=True)
    _createDate = StringField(required=True)

    @property
    def totalProjectPerState(self):
        return self._totalProjectPerState

    @totalProjectPerState.setter
    def totalProjectPerState(self, number):
        self._totalProjectPerState = number

    @property
    def totalProjectPerTypePerState(self):
        return self._totalProjectPerTypePerState

    @totalProjectPerTypePerState.setter
    def totalProjectPerTypePerState(self, number):
        self._totalProjectPerTypePerState = number

    @property
    def createDate(self):
        return self._createDate

    @createDate.setter
    def createDate(self, number):
        self._createDate = number


class PercentProjectThatAcceptOnlineTransitionsPerState(Document):
    _totalProjectThatAcceptOnlineTransitionsPerState = MapField(required=True)
    _totalProjectPerState = MapField(required=True)
    _createDate = StringField(required=True)

    @property
    def totalProjectPerState(self):
        return self._totalProjectPerState

    @totalProjectPerState.setter
    def totalProjectPerState(self, number):
        self._totalProjecPerStatet = number

    @property
    def totalProjectThatAcceptOnlineTransitionsPerState(self):
        return self._totalProjectThatAcceptOnlineTransitionsPerState

    @totalProjectThatAcceptOnlineTransitionsPerState.setter
    def totalProjectThatAcceptOnlineTransitionsPerState(self, number):
        self._totalProjectThatAcceptOnlineTransitionsPerState = number

    @property
    def createDate(self):
        return self._createDate

    @createDate.setter
    def createDate(self, number):
        self._createDate = number

# -------------------- Project Registered -------------------------------------


class QuantityOfRegisteredProject(Document):
    _totalProjectRegisteredPerMounthPerYear = MapField(required=True)
    _totalProjectRegisteredPerYear = MapField(required=True)
    _totalProject = IntField(required=True)
    _createDate = StringField(required=True)

    @property
    def totalProjectRegisteredPerMounthPerYear(self):
        return self._totalProjectRegisteredPerMounthPerYear

    @totalProjectRegisteredPerMounthPerYear.setter
    def totalProjectRegisteredPerMounthPerYear(self, number):
        self._totalProjectRegisteredPerMounthPerYear = number

    @property
    def totalProjectRegisteredPerYear(self):
        return self._totalProjectRegisteredPerYear

    @totalProjectRegisteredPerYear.setter
    def totalProjectRegisteredPerYear(self, number):
        self._totalProjectRegisteredPerYear = number

    @property
    def totalProject(self):
        return self._totalProject

    @totalProject.setter
    def totalProject(self, number):
        self._totalProject = number

    @property
    def createDate(self):
        return self._createDate

    @createDate.setter
    def createDate(self, number):
        self._createDate = number

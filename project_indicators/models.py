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

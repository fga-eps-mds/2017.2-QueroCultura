# from django.db import models
from mongoengine import Document
from mongoengine import MapField
from mongoengine import IntField
from mongoengine import StringField

# --------------------- national indicators ----------------------------------


class PercentSpacePerType(Document):
    _totalSpace = IntField(required=True)
    _totaSpacePerType = MapField(required=True)
    _createDate = StringField(required=True)

    @property
    def totalSpace(self):
        return self._totalSpace

    @totalSpace.setter
    def totalSpace(self, number):
        self._totalSpace = number

    @property
    def totalSpacePerType(self):
        return self._totalSpacePerType

    @totalSpacePerType.setter
    def totalSpacePerType(self, number):
        self._totalSpacePerType = number

    @property
    def createDate(self):
        return self._createDate

    @createDate.setter
    def createDate(self, number):
        self._createDate = number


class PercentSpacePerOccupationArea(Document):
    _totalSpacePerOccupationArea = MapField(required=True)
    _totalSpace = IntField(required=True)
    _createDate = StringField(required=True)

    @property
    def totalSpace(self):
        return self._totalSpace

    @totalSpace.setter
    def totalSpace(self, number):
        self._totalSpace = number

    @property
    def totalSpacePerOccupationArea(self):
        return self._totalSpacePerOccupationArea

    @totalSpacePerOccupationArea.setter
    def totalSpacePerOccupationArea(self, number):
        self._totalSpacePerOccupationArea = number

    @property
    def createDate(self):
        return self._createDate

    @createDate.setter
    def createDate(self, number):
        self._createDate = number

# -------------------- state indicators --------------------------------------


class PercentSpacePerTypePerState(Document):
    _totalSpacePerState = MapField(required=True)
    _totaSpacePerTypePerState = MapField(required=True)
    _createDate = StringField(required=True)

    @property
    def totalSpacePerState(self):
        return self._totalSpacePerState

    @totalSpacePerState.setter
    def totalSpacePerState(self, number):
        self._totalSpacPerStatee = number

    @property
    def totalSpacePerTypePerState(self):
        return self._totalSpacePerTypePerState

    @totalSpacePerTypePerState.setter
    def totalSpacePerTypePerState(self, number):
        self._totalSpacePerTypePerState = number

    @property
    def createDate(self):
        return self._createDate

    @createDate.setter
    def createDate(self, number):
        self._createDate = number


class PercentSpacePerOccupationAreaPerState(Document):
    _totalSpacePerOccupationAreaPerState = MapField(required=True)
    _totalSpacePerState = MapField(required=True)
    _createDate = StringField(required=True)

    @property
    def totalSpacePerState(self):
        return self._totalSpacePerState

    @totalSpacePerState.setter
    def totalSpacePerState(self, number):
        self._totalSpacePerState = number

    @property
    def totalSpacePerOccupationAreaPerState(self):
        return self._totalSpacePerOccupationAreaPerState

    @totalSpacePerOccupationAreaPerState.setter
    def totalSpacePerOccupationAreaPerState(self, number):
        self._totalSpacePerOccupationArea = number

    @property
    def createDate(self):
        return self._createDate

    @createDate.setter
    def createDate(self, number):
        self._createDate = number


class PercentSpaceForState(Document):
    _totalSpaces = IntField(required=True)
    _totalSpacePerState = MapField(required=True)
    _createDate = StringField(required=True)

    @property
    def totalSpaces(self):
        return self._totalSpaces

    @totalSpaces.setter
    def totalSpaces(self, number):
        self._totalSpaces = number

    @property
    def totalSpacePerState(self):
        return self._totalSpacePerState

    @totalSpacePerState.setter
    def totalSpacePerState(self, number):
        self._totalSpacePerState = number

    @property
    def createDate(self):
        return self._createDate

    @createDate.setter
    def createDate(self, number):
        self._createDate = number


# -------------------- Space Registered --------------------------------------


class QuantityOfRegisteredSpace(Document):
    _totalSpaceRegisteredPerMounthPerYear = MapField(required=True)
    _totalSpaceRegisteredPerYear = MapField(required=True)
    _totalSpace = IntField(required=True)
    _createDate = StringField(required=True)

    @property
    def totalSpaceRegisteredPerMounthPerYear(self):
        return self._totalSpaceRegisteredPerMounthPerYear

    @totalSpaceRegisteredPerMounthPerYear.setter
    def totalSpaceRegisteredPerMounthPerYear(self, number):
        self._totalSpaceRegisteredPerMounthPerYear = number

    @property
    def totalSpaceRegisteredPerYear(self):
        return self._totalSpaceRegisteredPerYear

    @totalSpaceRegisteredPerYear.setter
    def totalSpaceRegisteredPerYear(self, number):
        self._totalSpaceRegisteredPerYear = number

    @property
    def totalSpace(self):
        return self._totalSpace

    @totalSpace.setter
    def totalSpace(self, number):
        self._totalSpace = number

    @property
    def createDate(self):
        return self._createDate

    @createDate.setter
    def createDate(self, number):
        self._createDate = number

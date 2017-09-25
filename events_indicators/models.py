# from django.db import models
from mongoengine import Document
from mongoengine import MapField
from mongoengine import IntField
from mongoengine import StringField

# --------------------- national indicators ----------------------------------


class PercentEventsPerLanguage(Document):
    _totalEvents = IntField(required=True)
    _totaEventsPerLanguage = MapField(required=True)
    _createDate = StringField(required=True)

    @property
    def totalEvents(self):
        return self._totalEvents

    @totalEvents.setter
    def totalEvents(self, number):
        self._totalEvents = number

    @property
    def totalEventsPerLanguage(self):
        return self._totalEventsPerLanguage

    @totalEventsPerLanguage.setter
    def totalEventsPerLanguage(self, number):
        self._totalEventsPerLanguage = number

    @property
    def createDate(self):
        return self._createDate

    @createDate.setter
    def createDate(self, number):
        self._createDate = number


class PercentEventsPerAgeRange(Document):
    _totalEventsPerAgeRange = MapField(required=True)
    _totalEvents = IntField(required=True)
    _createDate = StringField(required=True)

    @property
    def totalEvents(self):
        return self._totalEvents

    @totalEvents.setter
    def totalEvents(self, number):
        self._totalEvents = number

    @property
    def totalEventsPerAgeRange(self):
        return self._totalEventsPerAgeRange

    @totalEventsPerAgeRange.setter
    def totalEventsPerAgeRange(self, number):
        self._totalEventsPerAgeRange = number

    @property
    def createDate(self):
        return self._createDate

    @createDate.setter
    def createDate(self, number):
        self._createDate = number

# -------------------- state indicators --------------------------------------


class PercentTypeEventsForState(Document):
    _typeStateEvents = MapField(required=True)
    _totalStateEvents = MapField(required=True)
    _createDate = StringField(required=True)

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

    @property
    def createDate(self):
        return self._createDate

    @createDate.setter
    def createDate(self, number):
        self._createDate = number


class PercentEventsPerLanguagePerState(Document):
    _totalEventsPerState = MapField(required=True)
    _totaEventsPerLanguagePerState = MapField(required=True)
    _createDate = StringField(required=True)

    @property
    def totalEventsPerState(self):
        return self._totalEventsPerState

    @totalEventsPerState.setter
    def totalEventsPerState(self, number):
        self._totalEvents = number

    @property
    def totalEventsPerLanguagePerState(self):
        return self._totalEventsPerLanguage

    @totalEventsPerLanguagePerState.setter
    def totalEventsPerLanguagePerState(self, number):
        self._totalEventsPerLanguage = number

    @property
    def createDate(self):
        return self._createDate

    @createDate.setter
    def createDate(self, number):
        self._createDate = number


class PercentEventsPerAgeRangePerState(Document):
    _totalEventsPerAgeRangePerState = MapField(required=True)
    _totalEventsPerState = IntField(required=True)
    _createDate = StringField(required=True)

    @property
    def totalEventsPerState(self):
        return self._totalEventsPerState

    @totalEventsPerState.setter
    def totalEventsPerState(self, number):
        self._totalEventsPerState = number

    @property
    def totalEventsPerAgeRangePerState(self):
        return self._totalEventsPerAgeRangePerState

    @totalEventsPerAgeRangePerState.setter
    def totalEventsPerAgeRange(self, number):
        self._totalEventsPerAgeRangePerState = number

    @property
    def createDate(self):
        return self._createDate

    @createDate.setter
    def createDate(self, number):
        self._createDate = number

# -------------------- Events Registered --------------------------------------


class QuantityOfRegisteredEvents(Document):
    _totalEventsRegisteredPerMounthPerYear = MapField(required=True)
    _totalEventsRegisteredPerYear = MapField(required=True)
    _totalEvents = IntField(required=True)
    _createDate = StringField(required=True)

    @property
    def totalEventsRegisteredPerMounthPerYear(self):
        return self._totalEventsRegisteredPerMounthPerYear

    @totalEventsRegisteredPerMounthPerYear.setter
    def totalEventsRegisteredPerMounthPerYear(self, number):
        self._totalEventsRegisteredPerMounthPerYear = number

    @property
    def totalEventsRegisteredPerYear(self):
        return self._totalEventsRegisteredPerYear

    @totalEventsRegisteredPerYear.setter
    def totalEventsRegisteredPerYear(self, number):
        self._totalEventsRegisteredPerYear = number

    @property
    def totalEvents(self):
        return self._totalEvents

    @totalEvents.setter
    def totalEvents(self, number):
        self._totalEvents = number

    @property
    def createDate(self):
        return self._createDate

    @createDate.setter
    def createDate(self, number):
        self._createDate = number

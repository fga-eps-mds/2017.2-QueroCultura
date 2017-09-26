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
    def total_events(self):
        return self._totalEvents

    @total_events.setter
    def total_events(self, number):
        self._totalEvents = number

    @property
    def total_events_per_language(self):
        return self._totalEventsPerLanguage

    @total_events_per_language.setter
    def total_events_per_language(self, number):
        self._totalEventsPerLanguage = number

    @property
    def create_date(self):
        return self._createDate

    @create_date.setter
    def create_date(self, number):
        self._createDate = number


class PercentEventsPerAgeRange(Document):
    _totalEventsPerAgeRange = MapField(required=True)
    _totalEvents = IntField(required=True)
    _createDate = StringField(required=True)

    @property
    def total_events(self):
        return self._totalEvents

    @total_events.setter
    def totalEvents(self, number):
        self._totalEvents = number

    @property
    def total_events_per_age_range(self):
        return self._totalEventsPerAgeRange

    @total_events_per_age_range.setter
    def total_events_per_age_range(self, number):
        self._totalEventsPerAgeRange = number

    @property
    def create_date(self):
        return self._createDate

    @create_date.setter
    def create_date(self, number):
        self._createDate = number

# -------------------- state indicators --------------------------------------


class PercentTypeEventsForState(Document):
    _typeStateEvents = MapField(required=True)
    _totalStateEvents = MapField(required=True)
    _createDate = StringField(required=True)

    @property
    def type_state_events(self):
        return self._typeStateEvents

    @type_state_events.setter
    def type_state_events(self, number):
        self._typeStateEvents = number

    @property
    def total_state_events(self):
        return self._totalStateEvents

    @total_state_events.setter
    def total_state_events(self, number):
        self._totalStateEvents = number

    @property
    def create_date(self):
        return self._createDate

    @create_date.setter
    def create_date(self, number):
        self._createDate = number


class PercentEventsPerLanguagePerState(Document):
    _totalEventsPerState = MapField(required=True)
    _totaEventsPerLanguagePerState = MapField(required=True)
    _createDate = StringField(required=True)

    @property
    def total_events_per_state(self):
        return self._totalEventsPerState

    @total_events_per_state.setter
    def total_events_per_state(self, number):
        self._totalEvents = number

    @property
    def total_events_per_language_per_state(self):
        return self._totalEventsPerLanguage

    @total_events_per_language_per_state.setter
    def total_events_per_language_per_state(self, number):
        self._totalEventsPerLanguage = number

    @property
    def create_date(self):
        return self._createDate

    @create_date.setter
    def create_date(self, number):
        self._createDate = number


class PercentEventsPerAgeRangePerState(Document):
    _totalEventsPerAgeRangePerState = MapField(required=True)
    _totalEventsPerState = IntField(required=True)
    _createDate = StringField(required=True)

    @property
    def total_events_per_state(self):
        return self._totalEventsPerState

    @total_events_per_state.setter
    def total_events_per_state(self, number):
        self._totalEventsPerState = number

    @property
    def total_events_per_age_range_per_state(self):
        return self._totalEventsPerAgeRangePerState

    @total_events_per_age_range_per_state.setter
    def total_events_per_age_range(self, number):
        self._totalEventsPerAgeRangePerState = number

    @property
    def create_date(self):
        return self._createDate

    @create_date.setter
    def create_date(self, number):
        self._createDate = number

# -------------------- Events Registered --------------------------------------


class QuantityOfRegisteredEvents(Document):
    _totalEventsRegisteredPerMounthPerYear = MapField(required=True)
    _totalEventsRegisteredPerYear = MapField(required=True)
    _totalEvents = IntField(required=True)
    _createDate = StringField(required=True)

    @property
    def total_events_registered_per_mounth_per_year(self):
        return self._totalEventsRegisteredPerMounthPerYear

    @total_events_registered_per_mounth_per_year.setter
    def total_events_registered_per_mounth_per_year(self, number):
        self._totalEventsRegisteredPerMounthPerYear = number

    @property
    def total_events_registered_per_year(self):
        return self._totalEventsRegisteredPerYear

    @total_events_registered_per_year.setter
    def total_events_registered_per_year(self, number):
        self._totalEventsRegisteredPerYear = number

    @property
    def total_events(self):
        return self._totalEvents

    @total_events.setter
    def total_events(self, number):
        self._totalEvents = number

    @property
    def create_date(self):
        return self._createDate

    @create_date.setter
    def create_date(self, number):
        self._createDate = number

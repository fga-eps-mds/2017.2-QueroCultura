# from django.db import models
from mongoengine import Document
from mongoengine import DictField
from mongoengine import IntField
from mongoengine import DateTimeField

# --------------------- national indicators ----------------------------------


class PercentEventsInAccessibleSpaces(Document):
    _totalEvents = IntField(required=True)
    _totalEventsInAccessibleSpaces = DictField(required=True)
    _createDate = DateTimeField(required=True)

    @property
    def total_events(self):
        return self._totalEvents

    @total_events.setter
    def total_events(self, number):
        self._totalEvents = number

    @property
    def total_events_in_accessible_spaces(self):
        return self._totalEventsInAccessibleSpaces

    @total_events_in_accessible_spaces.setter
    def total_events_in_accessible_spaces(self, number):
        self._totalEventsInAccessibleSpaces = number

    @property
    def create_date(self):
        return self._createDate

    @create_date.setter
    def create_date(self, number):
        self._createDate = number


class PercentEventsInMoreThenOneSpace(Document):
    _totalEvents = IntField(required=True)
    _totalEventsInMoreThenOneSpace = DictField(required=True)
    _createDate = DateTimeField(required=True)

    @property
    def total_events(self):
        return self._totalEvents

    @total_events.setter
    def total_events(self, number):
        self._totalEvents = number

    @property
    def total_events_in_more_then_one_space(self):
        return self._totalEventsInMoreThenOneSpace

    @total_events_in_more_then_one_space.setter
    def total_events_in_more_then_one_space(self, number):
        self._totalEventsInMoreThenOneSpace = number

    @property
    def create_date(self):
        return self._createDate

    @create_date.setter
    def create_date(self, number):
        self._createDate = number

# -------------------- state indicators --------------------------------------


class PercentEventsInAccessibleSpacesPerState(Document):
    _totalEventsPerState = DictField(required=True)
    _totalEventsInAccessibleSpacesPerState = DictField(required=True)
    _createDate = DateTimeField(required=True)

    @property
    def total_events_per_state(self):
        return self._totalEventsPerState

    @total_events_per_state.setter
    def total_events_per_state(self, number):
        self._totalEventsPerState = number

    @property
    def total_events_in_accessible_spaces(self):
        return self._totalEventsInAccessibleSpacesPerState

    @total_events_in_accessible_spaces.setter
    def total_events_in_accessible_spaces(self, number):
        self._totalEventsInAccessibleSpacesPerState = number

    @property
    def create_date(self):
        return self._createDate

    @create_date.setter
    def create_date(self, number):
        self._createDate = number


class PercentEventsInMoreThenOneSpacePerState(Document):
    _totalEventsPerState = DictField(required=True)
    _totalEventsInMoreThenOneSpacePerState = DictField(required=True)
    _createDate = DateTimeField(required=True)

    @property
    def total_events_per_state(self):
        return self._totalSpace

    @total_events_per_state.setter
    def total_events_per_state(self, number):
        self._totalEventsPerState = number

    @property
    def total_events_in_more_then_one_space(self):
        return self._totalEventsInMoreThenOneSpacePerState

    @total_events_in_more_then_one_space.setter
    def total_events_in_more_then_one_space(self, number):
        self._totalEventsInMoreThenOneSpacePerState = number

    @property
    def create_date(self):
        return self._createDate

    @create_date.setter
    def create_date(self, number):
        self._createDate = number

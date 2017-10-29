from mongoengine import Document
from mongoengine import IntField
from mongoengine import DictField
from mongoengine import DateTimeField


class PercentEvent(Document):
    class Meta:
        abstract = True
    meta = {'allow_inheritance': True}

    _total_events = IntField(required=True)
    _create_date = DateTimeField(required=True)

    @property
    def create_date(self):
        return self._create_date

    @create_date.setter
    def create_date(self, number):
        self._create_date = number

    @property
    def total_events(self):
        return self._total_events

    @total_events.setter
    def total_events(self, number):
        self._total_events = number


class PercentEventsPerLanguage(PercentEvent):
    _total_events_per_language = DictField(required=True)

    @property
    def total_events_per_language(self):
        return self._tota_events_per_language

    @total_events_per_language.setter
    def total_events_per_language(self, number):
        self._total_events_per_language = number


class PercentEventsPerAgeRange(PercentEvent):
    _total_events_per_age_range = DictField(required=True)

    @property
    def total_events_per_age_range(self):
        return self._total_events_per_age_range

    @total_events_per_age_range.setter
    def total_events_per_age_range(self, number):
        self._total_events_per_age_range = number


class QuantityOfRegisteredEvents(PercentEvent):
    _total_events_registered_per_mounth_per_year = DictField(required=True)

    @property
    def total_events_registered_per_mounth_per_year(self):
        return self._total_events_registered_per_mounth_per_year

    @total_events_registered_per_mounth_per_year.setter
    def total_events_registered_per_mounth_per_year(self, number):
        self._total_events_registered_per_mounth_per_year = number

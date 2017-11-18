from mongoengine import Document
from mongoengine import IntField
from mongoengine import DictField
from mongoengine import DateTimeField


class LastUpdateEventDate(Document):
    _create_date = StringField(required=True)

    @property
    def create_date(self):
        return self._create_date

    @create_date.setter
    def create_date(self, create_date):
        self._create_date = create_date


class EventLanguage(Document):
    _instance = StringField(required=True)
    _event_language = StringField(required=True)

    @property
    def instance(self):
        return self._instance

    @instance.setter
    def instance(self, instance):
        self._instance = instance

    @property
    def event_language(self):
        return self._event_language

    @event_language.setter
    def event_language(self, event_language):
        self._event_language = event_language



class EventData(Document):
    _instance = StringField(required=True)
    _event_type = StringField(required=True)
    _classificacao_etaria = StringField(required=True)
    _date = DateTimeField(required=True)


        @property
        def instance(self):
            return self._instance

        @instance.setter
        def instance(self, instance):
            self._instance = instance

        @property
        def date(self):
            return self._date

        @date.setter
        def date(self, date):
            self._date = date

        @property
        def classificacao_etaria(self):
            return self._classificacao_etaria

        @classificacao_etaria.setter
        def classificacao_etaria(self, classificacao_etaria):
            self._classificacao_etaria = classificacao_etaria

        @property
        def event_type(self):
            return self._event_type

        @event_type.setter
        def event_type(self, event_type):
            self._event_type = event_type


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
        return self._total_events_per_language

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

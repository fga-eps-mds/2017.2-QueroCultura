from mongoengine import Document
from mongoengine import DictField
from mongoengine import IntField
from mongoengine import DateTimeField

# --------------------- national indicators ----------------------------------

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

class PercentEventState(Document):
    class Meta:
        abstract = True
    meta = {'allow_inheritance': True}

    _total_state_events = DictField(required=True)
    _create_date = DateTimeField(required=True)

    @property
    def total_state_events(self):
        return self._total_state_events

    @total_state_events.setter
    def total_state_events(self, number):
        self._total_state_events = number

    @property
    def create_date(self):
        return self._create_date

    @create_date.setter
    def create_date(self, number):
        self._create_date = number


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



# -------------------- state indicators --------------------------------------


class PercentTypeEventsForState(PercentEventState):
    _type_state_events = DictField(required=True)


    @property
    def type_state_events(self):
        return self._type_state_events

    @type_state_events.setter
    def type_state_events(self, number):
        self._type_state_events = number




class PercentEventsPerLanguagePerState(PercentEventState):
    _total_events_language_state = DictField(required=True)


    @property
    def total_events_language_state(self):
        return self._total_events_language_state

    @total_events_language_state.setter
    def total_events_language_state(self, number):
        self._total_events_language_state = number



class PercentEventsPerAgeRangePerState(PercentEventState):
    _total_events_age_range_state = DictField(required=True)


    @property
    def total_events_age_range_state(self):
        return self._total_events_age_range_state

    @total_events_age_range_state.setter
    def total_events_age_range_state(self, number):
        self._total_events_age_range_state = number

# -------------------- Events Registered --------------------------------------


class QuantityOfRegisteredEvents(PercentEvent):
    _total_events_registered_per_mounth_per_year = DictField(required=True)
    _total_events_registered_per_year = DictField(required=True)

    @property
    def total_events_registered_per_mounth_per_year(self):
        return self._total_events_registered_per_mounth_per_year

    @total_events_registered_per_mounth_per_year.setter
    def total_events_registered_per_mounth_per_year(self, number):
        self._total_events_registered_per_mounth_per_year = number

    @property
    def total_events_registered_per_year(self):
        return self._total_events_registered_per_year

    @total_events_registered_per_year.setter
    def total_events_registered_per_year(self, number):
        self._total_events_registered_per_year = number

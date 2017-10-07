from mongoengine import Document
from mongoengine import DictField
from mongoengine import IntField
from mongoengine import DateTimeField

# --------------------- national indicators ----------------------------------
class PercentEventMixIndicator(Document):
    class Meta:
        abstract = True

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

class PercentEventMixIndicatorState(Document):
    class Meta:
        abstract = True
    _total_events_per_state = DictField(required=True)
    _create_date = DateTimeField(required=True)
    @property
    def create_date(self):
        return self._create_date

    @create_date.setter
    def create_date(self, number):
        self._create_date = number

    @property
    def total_events_per_state(self):
        return self._total_events_per_state

    @total_events_per_state.setter
    def total_events_per_state(self, number):
        self._total_events_per_state = number

class PercentEventsInAccessibleSpaces(PercentEventMixIndicator):

    _total_events_in_accessible_spaces = DictField(required=True)

    @property
    def total_events_in_accessible_spaces(self):
        return self._total_events_in_accessible_spaces

    @total_events_in_accessible_spaces.setter
    def total_events_in_accessible_spaces(self, number):
        self._total_events_in_accessible_spaces = number



class PercentEventsInMoreThenOneSpace(PercentEventMixIndicator):
    _total_events_in_more_then_one_space = DictField(required=True)


    @property
    def total_events_in_more_then_one_space(self):
        return self._total_events_in_more_then_one_space

    @total_events_in_more_then_one_space.setter
    def total_events_in_more_then_one_space(self, number):
        self._totalEventsInMoreThenOneSpace = number



# -------------------- state indicators --------------------------------------


class PercentEventsInAccessibleSpacesPerState(PercentEventMixIndicatorState):

    _totalEventsInAccessibleSpacesPerState = DictField(required=True)

    @property
    def total_events_in_accessible_spaces(self):
        return self._totalEventsInAccessibleSpacesPerState

    @total_events_in_accessible_spaces.setter
    def total_events_in_accessible_spaces(self, number):
        self._totalEventsInAccessibleSpacesPerState = number


class PercentEventsInMoreThenOneSpacePerState(PercentEventMixIndicatorState):
    _total_events_in_more_then_one_space_per_state = DictField(required=True)

    @property
    def total_events_in_more_then_one_space(self):
        return self._total_events_in_more_then_one_space_per_state

    @total_events_in_more_then_one_space.setter
    def total_events_in_more_then_one_space(self, number):
        self._total_events_in_more_then_one_space_per_state = number

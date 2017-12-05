from mongoengine import Document
from mongoengine import StringField
from mongoengine import DateTimeField

class LastUpdateMixedDate(Document):
    _create_date = StringField(required=True)

    @property
    def create_date(self):
        return self._create_date

    @create_date.setter
    def create_date(self, create_date):
        self._create_date = create_date


class EventAndSpaceData(Document):
    _instance = StringField(required=True)
    _name = StringField(required=True)
    _event_id = StringField(required=True)
    _date = DateTimeField(required=True)
    _accessible_space = StringField(required=True)

    @property
    def event_id(self):
        return self._event_id

    @event_id.setter
    def event_id(self, event_id):
        self._event_id = event_id

    @property
    def accessible_space(self):
        return self._accessible_space

    @accessible_space.setter
    def accessible_space(self, accessible_space):
        self._accessible_space = accessible_space

    @property
    def name(self):
        return self._name

    @name.setter
    def name(sel, name):
        self._name = name

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

from mongoengine import Document
from mongoengine import StringField
from mongoengine import DateTimeField


class EventAndSpaceData(Document):
    _instance = StringField(required=True)
    _accessible_space = StringField(required=True)
    _date = DateTimeField(required=True)

    @property
    def accessible_space(self):
        return self._accessible_space

    @accessible_space.setter
    def accessible_space(self, accessible_space):
        self._accessible_space = accessible_space

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

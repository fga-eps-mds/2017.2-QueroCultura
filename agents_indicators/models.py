from mongoengine import Document
from mongoengine import StringField
from mongoengine import DateTimeField


class LastUpdateAgentsDate(Document):
    _create_date = StringField(required=True)

    @property
    def create_date(self):
        return self._create_date

    @create_date.setter
    def create_date(self, create_date):
        self._create_date = create_date


class AgentsArea(Document):
    _instance = StringField(required=True)
    _area = StringField(required=True)

    @property
    def instance(self):
        return self._instance

    @instance.setter
    def instance(self, instance):
        self._instance = instance

    @property
    def area(self):
        return self._area

    @area.setter
    def area(self, area):
        self._area = area


class AgentsData(Document):
    _instance = StringField(required=True)
    _agents_type = StringField(required=True)
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
    def agents_type(self):
        return self._agents_type

    @agents_type.setter
    def agents_type(self, agents_type):
        self._agents_type = agents_type

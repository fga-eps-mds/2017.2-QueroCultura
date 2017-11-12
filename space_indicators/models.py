from mongoengine import Document
from mongoengine import StringField


class LastUpdateDate(Document):
    _create_date = StringField(required=True)

    @property
    def create_date(self):
        return self._create_date

    @create_date.setter
    def create_date(self, create_date):
        self._create_date = create_date


class PerOccupationArea(Document):
    _instance = StringField(required=True)
    _occupation_area = StringField(required=True)
    _name = StringField(required=True)

    @property
    def instance(self):
        return self._instance

    @instance.setter
    def instance(self, instance):
        self._instance = instance

    @property
    def occupation_area(self):
        return self._occupation_area

    @occupation_area.setter
    def occupation_area(self, occupation_area):
        self._occupation_area = occupation_area

    @property
    def name(self):
        return self._name

    @name.setter
    def name(self, name):
        self._name = name

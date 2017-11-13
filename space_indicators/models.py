from mongoengine import Document
from mongoengine import StringField
from mongoengine import DateTimeField


class LastUpdateDate(Document):
    _create_date = StringField(required=True)

    @property
    def create_date(self):
        return self._create_date

    @create_date.setter
    def create_date(self, create_date):
        self._create_date = create_date


class SpaceData(Document):
    _instance = StringField(required=True)
    _occupation_area = StringField(required=True)
    _name = StringField(required=True)
    _date = DateTimeField(required=True)
    _space_type = StringField(required=True)

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

    @property
    def date(self):
        return self._date

    @date.setter
    def date(self, date):
        self._date = date

    @property
    def space_type(self):
        return self._space_type

    @space_type.setter
    def space_type(self, space_type):
        self._space_type = space_type

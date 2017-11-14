from mongoengine import Document
from mongoengine import IntField
from mongoengine import StringField
from mongoengine import DateTimeField

# -------------------- musuem indicators --------------------------------


class LastUpdateDate(Document):
    _create_date = StringField(required=True)

    @property
    def create_date(self):
        return self._create_date

    @create_date.setter
    def create_date(self, create_date):
        self._create_date = create_date


class OccupationArea(Document):
    _instance = StringField(required=True)
    _occupation_area = StringField(required=True)

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

class MuseumData(Document):
    abstract = True
    meta = {'allow_inheritance': True}

    _instance = StringField(required=True)
    _name = StringField(required=True)
    _date = DateTimeField(required=True)
    _museum_type = StringField(required=True)
    _accessibility = StringField(required=True)

    @property
    def instance(self):
        return self._instance

    @instance.setter
    def instance(self, instance):
        self._instance = instance

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
    def museum_type(self):
        return self._museum_type

    @museum_type.setter
    def museum_type(self, museum_type):
        self._museum_type = museum_type

    @property
    def accessibility(self):
        return self._accessibility

    @accessibility.setter
    def accessibility(self, accessibility):
        self._accessibility = accessibility

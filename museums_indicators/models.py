from mongoengine import Document
from mongoengine import StringField
from mongoengine import DateTimeField


class LastUpdateMuseumDate(Document):
    _create_date = StringField(required=True)

    @property
    def create_date(self):
        return self._create_date

    @create_date.setter
    def create_date(self, create_date):
        self._create_date = create_date


class MuseumArea(Document):
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


class MuseumTags(Document):
    _instance = StringField(required=True)
    _tag = StringField(required=True)

    @property
    def instance(self):
        return self._instance

    @instance.setter
    def instance(self, instance):
        self._instance = instance

    @property
    def tag(self):
        return self._tag

    @tag.setter
    def tag(self, tag):
        self._tag = tag


class MuseumData(Document):
    _instance = StringField(required=True)
    _museum_type = StringField(required=True)
    _accessibility = StringField(default='Não definido')
    _date = DateTimeField(required=True)

    @property
    def instance(self):
        return self._instance

    @instance.setter
    def instance(self, instance):
        self._instance = instance

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

    @property
    def date(self):
        return self._date

    @date.setter
    def date(self, date):
        self._date = date

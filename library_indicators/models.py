from mongoengine import Document
from mongoengine import DateTimeField
from mongoengine import StringField


class LastUpdateLibraryDate(Document):
    _create_date = StringField(required=True)

    @property
    def create_date(self):
        return self._create_date

    @create_date.setter
    def create_date(self, create_date):
        self._create_date = create_date


class LibraryArea(Document):
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


class LibraryData(Document):
    _instance = StringField(required=True)
    _sphere = StringField(required=True)
    _sphere_type = StringField(required=True)
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
    def sphere(self):
        return self._sphere

    @sphere.setter
    def sphere(self, sphere):
        self._sphere = sphere

    @property
    def sphere_type(self):
        return self._sphere_type

    @sphere_type.setter
    def sphere_type(self, sphere_type):
        self._sphere_type = sphere_type

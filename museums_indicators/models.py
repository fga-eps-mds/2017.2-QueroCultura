from mongoengine import Document
from mongoengine import IntField
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


class MuseumData(Document):

    _instance = StringField(required=True)
    _museum_type = StringField(required=True)
    _tematic = StringField(required=True)
    _sphere = StringField(required=True)
    _guided_tuor = StringField(required=True)
    _plubic_archive = StringField(required=True)
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
    def date(self):
        return self._date

    @date.setter
    def date(self, date):
        self._date = date

    @property
    def tematic(self):
        return self._tematic

    @tematic.setter
    def tematic(self,tematic):
        self._tematic = tematic

    @property
    def sphere(self):
        return self._sphere

    @sphere.setter
    def sphere(self, sphere):
        self._sphere = sphere

    @property
    def guided_tuor(self):
        return self._guided_tuor

    @guided_tuor.setter
    def guided_tuor(self, guided_tuor):
        self._guided_tuor = guided_tuor

    @property
    def public_archive(self):
        return self._public_archive

    @public_archive.setter
    def public_archive(self, public_archive):
        self._public_archive = public_archive

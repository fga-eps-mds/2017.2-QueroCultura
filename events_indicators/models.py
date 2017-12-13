from mongoengine import Document
from mongoengine import StringField
from mongoengine import DateTimeField
from mongoengine import ListField


class LastUpdateEventDate(Document):
    _create_date = StringField(required=True)

    @property
    def create_date(self):
        return self._create_date

    @create_date.setter
    def create_date(self, create_date):
        self._create_date = create_date


class EventLanguage(Document):
    _instance = StringField(required=True)
    _language = StringField(required=True)

    @property
    def instance(self):
        return self._instance

    @instance.setter
    def instance(self, instance):
        self._instance = instance

    @property
    def language(self):
        return self._language

    @language.setter
    def language(self, language):
        self._language = language


class EventData(Document):
    _instance = StringField(required=True)
    _age_range = StringField(required=True)
    _occurrences = ListField(required=False)
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
    def age_range(self):
        return self._age_range

    @age_range.setter
    def age_range(self, age_range):
        self._age_range = age_range

    @property
    def occurrences(self):
        return self._occurrences

    @occurrences.setter
    def occurrences(self, occurrences):
        self._occurrences = occurrences

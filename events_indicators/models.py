from mongoengine import Document
from mongoengine import StringField
from mongoengine import DateTimeField


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
    _event_language = StringField(required=True)

    @property
    def instance(self):
        return self._instance

    @instance.setter
    def instance(self, instance):
        self._instance = instance

    @property
    def event_language(self):
        return self._event_language

    @event_language.setter
    def event_language(self, event_language):
        self._event_language = event_language


class EventData(Document):
    _instance = StringField(required=True)
    _event_type = StringField(required=True)
    _classificacao_etaria = StringField(required=True)
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
    def classificacao_etaria(self):
        return self._classificacao_etaria

    @classificacao_etaria.setter
    def classificacao_etaria(self, classificacao_etaria):
        self._classificacao_etaria = classificacao_etaria

    @property
    def event_type(self):
        return self._event_type

    @event_type.setter
    def event_type(self, event_type):
        self._event_type = event_type

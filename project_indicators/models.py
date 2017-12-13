from mongoengine import Document
from mongoengine import StringField
from mongoengine import DateTimeField


class LastUpdateProjectDate(Document):
    _create_date = StringField(required=True)

    @property
    def create_date(self):
        return self._create_date

    @create_date.setter
    def create_date(self, create_date):
        self._create_date = create_date


class ProjectData(Document):
    _instance = StringField(required=True)
    _project_type = StringField(required=True)
    _online_subscribe = StringField(required=True)
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
    def online_subscribe(self):
        return self._online_subscribe

    @online_subscribe.setter
    def online_subscribe(self, online_subscribe):
        self._online_subscribe = online_subscribe

    @property
    def project_type(self):
        return self._project_type

    @project_type.setter
    def project_type(self, project_type):
        self._project_type = project_type

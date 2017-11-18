from mongoengine import Document
from mongoengine import IntField
from mongoengine import StringField
from mongoengine import DictField


class LastUpdateDate(Document):
    _create_date = StringField(required=True)

    @property
    def create_date(self):
        return self._create_date

    @create_date.setter
    def create_date(self, create_date):
        self._create_date = create_date
 

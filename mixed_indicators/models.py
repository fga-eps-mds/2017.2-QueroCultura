from mongoengine import Document
from mongoengine import StringField
from mongoengine import DateTimeField

class LastUpdateMixedDate(Document):
    _create_date = StringField(required=True)

    @property
    def create_date(self):
        return self._create_date

    @create_date.setter
    def create_date(self, create_date):
        self._create_date = create_date

        

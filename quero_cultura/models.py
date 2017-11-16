from mongoengine import Document
from mongoengine import DictField
from mongoengine import StringField
from mongoengine import DateTimeField
from mongoengine import URLField
from mongoengine import IntField


class Marker(Document):
    marker_id = IntField(required=true)
    name = StringField(required=true)
    marker_type = StringField(required=true)
    action_type = StringField(required=true)
    city = StringField(default=None)
    state = StringField(default=None)
    single_url = URLField(required=true)
    subsite = StringField(default=None)
    create_time_stamp = DateTimeField(default=None)
    update_time_stamp = DateTimeField(default=None)
    location = DictField(required=true)


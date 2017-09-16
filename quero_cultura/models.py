from mongoengine import *

class MapPoint(Document):
    typePoint = StringField(max_length=30)
    idPoint = IntField(required = True)
    namePoint = StringField(max_length=100)
    latitudePoint = StringField(max_length=50)
    longitudePoint = StringField(max_length=50)
    shortDescription = StringField()

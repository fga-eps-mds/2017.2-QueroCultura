from django.db import models

class MapPoint(models.Model):
    typePoint = models.CharField(max_length=30)
    idPoint = models.IntegerField()
    namePoint = models.CharField(max_length=100)
    latitudePoint = models.CharField(max_length=50)
    longitudePoint = models.CharField(max_length=50)
    shortDescription = models.TextField()


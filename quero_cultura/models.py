from django.db import models

class MapPoint(models.Model):
    typePoint = models.CharField(max_lenght=30)
    idPoint = models.IntegerField()
    namePoint = models.CharField(max_lenght=100)
    latitudePoint = models.CharField(max_lenght=50)
    longitudePoint = models.CharField(max_lenght=50)

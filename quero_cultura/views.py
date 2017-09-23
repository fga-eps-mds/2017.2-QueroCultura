from django.shortcuts import render
from .models import MapPoint
from .api import MapPointsApi


def index(request):

	mapPoints = []
	
	for i in MapPointsApi().data:

		typePoint  = "space"
		idPoint = i["id"]
		namePoint = i["name"]
		latitudePoint = i["location"]["latitude"]
		longitudePoint = i["location"]["longitude"]
		shortDescription = i["shortDescription"]

		mapPoint = MapPoint(typePoint = typePoint, idPoint = idPoint, namePoint = namePoint, latitudePoint = latitudePoint, longitudePoint = longitudePoint, shortDescription = shortDescription)
		mapPoints.append(mapPoint)

	return render(request, 'quero_cultura/index.html', {'mapPoints' : mapPoints})
	
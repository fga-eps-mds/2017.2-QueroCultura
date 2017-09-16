from django.shortcuts import render
from .models import MapPoint	

def index(request):

	

	typePoint  = 'evento'
	idPoint = 1
	namePoint = 'Festa'
	latitudePoint = '-16.006930'
	longitudePoint = '-48.085224'

	mapPoint = MapPoint(typePoint = typePoint, idPoint = idPoint, namePoint = namePoint, latitudePoint = latitudePoint, longitudePoint = longitudePoint)
	mapPoint2 = MapPoint(typePoint = typePoint, idPoint = idPoint, namePoint = namePoint, latitudePoint = '-30', longitudePoint = '-24.002')
	mapPoints = []
	mapPoints.append(mapPoint)
	mapPoints.append(mapPoint2)


	
	return render(request, 'quero_cultura/index.html', {'mapPoints' : mapPoints})
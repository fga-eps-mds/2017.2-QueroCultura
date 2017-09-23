from django.shortcuts import render
from .models import MapPoint

def index(request):



	typePoint  = 'evento'
	idPoint = 1
	namePoint = 'Festa'
	latitudePoint = '-16.021958'
	longitudePoint = '-48.064078'


	mapPoint = MapPoint(typePoint = typePoint, idPoint = idPoint, namePoint = namePoint, latitudePoint = latitudePoint, longitudePoint = longitudePoint)
	mapPoint2 = MapPoint(typePoint = 'Agente', idPoint = idPoint, namePoint = namePoint, latitudePoint = '-17', longitudePoint = '-54.002')
	mapPoints = []
	mapPoints.append(mapPoint)
	mapPoints.append(mapPoint2)


	return render(request, 'quero_cultura/index.html', {'mapPoints' : mapPoints})

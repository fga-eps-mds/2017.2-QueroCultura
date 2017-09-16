from django.shortcuts import render
from .models import MapPoint	

def index(request):

	

	typePoint  = 'evento'
	idPoint = 1
	namePoint = 'Festa'
	latitudePoint = '-45.792'
	longitudePoint = '-17.320'

	mapPoint = MapPoint(typePoint = typePoint, idPoint = idPoint, namePoint = namePoint, latitudePoint = latitudePoint, longitudePoint = longitudePoint)

	
	return render(request, 'quero_cultura/index.html', {'mapPoint' : mapPoint})
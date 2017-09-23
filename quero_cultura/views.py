from django.shortcuts import render
from .models import MapPoint
from .api import MapPointsApi


def index(request):
	
	return render(request, 'quero_cultura/index.html', {})
	
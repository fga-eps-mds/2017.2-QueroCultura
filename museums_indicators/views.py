from datetime import datetime
from django.shortcuts import render
from .models import MuseumData
from .models import LastUpdateMuseumDate
from quero_cultura.views import ParserYAML
import json

DEFAULT_INITIAL_DATE = "2012-01-01 00:00:00.000000"
urls = ["http://museus.cultura.gov.br/api/"]


def index(request):

    return render(request, 'museums_indicators/museums-indicators.html')


def populate_museum_data():
    if len(LastUpdateMuseumDate.objects) == 0:
        LastUpdateMuseumDate(DEFAULT_INITIAL_DATE).save()

    size = LastUpdateMuseumDate.objects.count()
    last_update = LastUpdateMuseumDate.objects[size - 1].create_date

    LastUpdateMuseumDate(str(datetime.now())).save()

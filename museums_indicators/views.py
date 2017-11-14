from datetime import datetime
from django.shortcuts import render
from project_indicators.views import clean_url
from .models import MuseumData
from .models import OccupationArea
from .models import LastUpdateDate
from quero_cultura.views import ParserYAML
from .api_connections import TestMuseum
import json

DEFAULT_INITIAL_DATE = "2012-01-01 00:00:00.000000"




def index(request):

    return render(request, 'museums_indicators/museums-indicators.html')


def populate_museum_data():
    if len(LastUpdateDate.objects) == 0:
        LastUpdateDate(DEFAULT_INITIAL_DATE).save()

    size = LastUpdateDate.objects.count()
    last_update = LastUpdateDate.objects[size - 1].create_date

    parser_yaml = ParserYAML()
    urls = parser_yaml.get_multi_instances_urls

    for url in urls:
        request = TestMuseum(last_update, url).data
        new_url = clean_url(url)

        for museum in request:
            date = museum["createTimestamp"]['date']
            accessibility = str(museum['acessibilidade'])
            MuseumData(new_url, museum['name'], date,
                      museum['type']['name'], accessibility).save()
            for area in museum["terms"]["area"]:
                OccupationArea(new_url, area).save()

    LastUpdateDate(str(datetime.now())).save()

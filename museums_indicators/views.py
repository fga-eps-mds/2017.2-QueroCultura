from datetime import datetime
from django.shortcuts import render
from .models import MuseumData
from .models import MuseumArea
from .models import MuseumTags
from .models import LastUpdateMuseumDate
from quero_cultura.views import ParserYAML
from quero_cultura.views import get_metabase_url
from .api_connections import RequestMuseumRawData
from project_indicators.views import clean_url
from celery.decorators import task
import json

DEFAULT_INITIAL_DATE = "2012-01-01 00:00:00.000000"
urls = ["http://museus.cultura.gov.br/api/"]


def index(request):
    view_type = "question"

    url = {"graphic1": get_metabase_url(view_type, 18),
           "graphic2": get_metabase_url(view_type, 19),
           "graphic3": get_metabase_url(view_type, 20),
           "graphic4": get_metabase_url(view_type, 21),
           "graphic5": get_metabase_url(view_type, 22),
           "graphic6": get_metabase_url(view_type, 23),
           "graphic7": get_metabase_url(view_type, 24)}

    return render(request, 'museums_indicators/museums-indicators.html', url)


@task(name="populate_museum_data")
def populate_museum_data():
    if len(LastUpdateMuseumDate.objects) == 0:
        LastUpdateMuseumDate(DEFAULT_INITIAL_DATE).save()

    size = LastUpdateMuseumDate.objects.count()
    last_update = LastUpdateMuseumDate.objects[size - 1].create_date

    parser_yaml = ParserYAML()
    urls = parser_yaml.get_multi_instances_urls

    for url in urls:
        request = RequestMuseumRawData(last_update, url).data
        new_url = clean_url(url)
        for museum in request:
            date = museum["createTimestamp"]['date']

            accessibility = museum["acessibilidade"]
            if accessibility == '':
                accessibility = None


            MuseumData(new_url,
                       museum["type"]['name'],
                       accessibility,
                       date).save()

            for area in museum["terms"]["area"]:
                MuseumArea(new_url, area).save()

            for tag in museum["terms"]["tag"]:
                MuseumTags(new_url, tag).save()


    LastUpdateMuseumDate(str(datetime.now())).save()

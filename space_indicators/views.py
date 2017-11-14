from datetime import datetime
from django.shortcuts import render
from .api_connections import RequestSpacesRawData
from .models import SpaceData
from .models import LastUpdateDate
from project_indicators.views import clean_url
from quero_cultura.views import ParserYAML
from quero_cultura.views import get_metabase_url
from celery.decorators import task


DEFAULT_INITIAL_DATE = "2012-01-01 00:00:00.000000"


def index(request):
    view_type = "question"
    number = 2


    url = {"graphic1": get_metabase_url(view_type, 2),
           "graphic2": get_metabase_url(view_type, 4),
           "graphic3": get_metabase_url(view_type, 3),
           "graphic4": get_metabase_url(view_type, 6),
           "graphic5": get_metabase_url(view_type, 7)}
    return render(request, 'space_indicators/space-indicators.html', url)


@task(name="populate_space_data")
def populate_space_data():
    if len(LastUpdateDate.objects) == 0:
        LastUpdateDate(DEFAULT_INITIAL_DATE).save()

    size = LastUpdateDate.objects.count()
    last_update = LastUpdateDate.objects[size - 1].create_date

    parser_yaml = ParserYAML()
    urls = parser_yaml.get_multi_instances_urls

    for url in urls:
        request = RequestSpacesRawData(last_update, url).data
        new_url = clean_url(url)
        for space in request:
            for area in space["terms"]["area"]:
                date = space["createTimestamp"]['date']
                SpaceData(new_url, area, space['name'],
                          date, space['type']['name']).save()

    LastUpdateDate(str(datetime.now())).save()

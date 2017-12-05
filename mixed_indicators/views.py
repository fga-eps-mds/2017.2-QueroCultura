from django.shortcuts import render
from datetime import datetime
from .api_connections import RequestMixedIndicatorsRawData
from .models import LastUpdateMixedDate
from .models import EventAndSpaceData
from quero_cultura.views import ParserYAML
from quero_cultura.views import get_metabase_url
from project_indicators.views import clean_url

DEFAULT_INITIAL_DATE = "2012-01-01 00:00:00.000000"

# Create your views here.


def index(request):
    EventAndSpaceData.drop_collection()
    LastUpdateMixedDate.drop_collection()

    populate_mixed_data()
    return render(request, 'mixed_indicators/mixed-indicators.html')


def populate_mixed_data():
    if len(LastUpdateMixedDate.objects) == 0:
        LastUpdateMixedDate(DEFAULT_INITIAL_DATE).save()

    size = LastUpdateMixedDate.objects.count()
    las_update = LastUpdateMixedDate.objects[size - 1].create_date

    parser_yaml = ParserYAML()
    urls = parser_yaml.get_multi_instances_urls

    for url in urls:
        request = RequestMixedIndicatorsRawData(las_update, url).data
        new_url = clean_url(url)
        for mixed in request:
            date = mixed["createTimestamp"]['date']
            name = mixed['name']

            for occurrences in mixed['occurrences']:

                if occurrences['space'] != None:
                    accessible_space = occurrences['space']['acessibilidade']

                EventAndSpaceData(new_url, str(name), str(
                    accessible_space), date).save()

    LastUpdateMixedDate(str(datetime.now())).save()

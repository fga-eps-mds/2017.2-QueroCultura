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
            date = mixed["createTimestamp"]["date"]
            EventAndSpaceData(new_url, str(mixed['name']),
                              str(mixed['occurrences']['acessibilidade']),
                              date).save()

    LastUpdateMixedDate(str(datetime.now())).save()
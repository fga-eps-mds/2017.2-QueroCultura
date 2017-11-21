from django.shortcuts import render
from .api_connections import RequestEventsRawData
from .models import EventData
from .models import EventLanguage
from .models import LastUpdateEventDate
from project_indicators.views import clean_url
from quero_cultura.views import ParserYAML
from quero_cultura.views import get_metabase_url
from datetime import datetime
from celery.decorators import task

DEFAULT_INITIAL_DATE = "2012-01-01 15:47:38.337553"


def index(request):
    view_type = "question"

    url = {"graphic1": get_metabase_url(view_type, 14),
           "graphic2": get_metabase_url(view_type, 15),
           "graphic3": get_metabase_url(view_type, 16),
           "graphic4": get_metabase_url(view_type, 17)}

    return render(request, 'events_indicators/events_indicators.html', url)


@task(name="populate_event_data")
def populate_event_data():
    if len(LastUpdateEventDate.objects) == 0:
        LastUpdateEventDate(DEFAULT_INITIAL_DATE).save()

    size = LastUpdateEventDate.objects.count()
    last_update = LastUpdateEventDate.objects[size - 1].create_date

    parser_yaml = ParserYAML()
    urls = parser_yaml.get_multi_instances_urls

    for url in urls:
        request = RequestEventsRawData(last_update, url).data
        new_url = clean_url(url)
        for event in request:
            date = event["createTimestamp"]['date']
            EventData(new_url, str(event['classificacaoEtaria']), date).save()
            for language in event["terms"]["linguagem"]:
                EventLanguage(new_url, language).save()

    LastUpdateEventDate(str(datetime.now())).save()

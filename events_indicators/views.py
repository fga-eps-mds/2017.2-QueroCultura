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
from quero_cultura.views import instaces_counter

DEFAULT_INITIAL_DATE = "2012-01-01 15:47:38.337553"

# Get graphics urls from metabase
# To add new graphis, just add in the metabase_graphics variable
view_type = "question"
metabase_graphics = [{'id':1, 'url':get_metabase_url(view_type, 14,"true")},
                    {'id':2, 'url':get_metabase_url(view_type, 15,"true")},
                    {'id':3, 'url':get_metabase_url(view_type, 16,"true")},
                    {'id':4, 'url':get_metabase_url(view_type, 17,"true")}]

detailed_data = [{'id':1, 'url':get_metabase_url(view_type, 36,"false")},
                {'id':2, 'url':get_metabase_url(view_type, 37,"false")},
                {'id':3, 'url':get_metabase_url(view_type, 43,"false")}]


page_type = "Eventos"
graphic_type = 'events_graphic_detail'

def index(request):
    return render(request, 'quero_cultura/indicators_page.html', {'metabase_graphics':metabase_graphics, 'detailed_data':detailed_data,'page_type':page_type, 'graphic_type':graphic_type})

def graphic_detail(request, graphic_id):
    graphic = metabase_graphics[int(graphic_id) - 1]
    return render(request,'quero_cultura/graphic_detail.html',{'graphic': graphic})

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

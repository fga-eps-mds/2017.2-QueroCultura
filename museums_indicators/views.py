from datetime import datetime
from django.shortcuts import render
from .models import MuseumData
from .models import LastUpdateMuseumDate
from quero_cultura.views import ParserYAML
from quero_cultura.views import get_metabase_url
from .api_connections import RequestMuseumRawData
from project_indicators.views import clean_url
from celery.decorators import task
import json

DEFAULT_INITIAL_DATE = "2012-01-01 00:00:00.000000"
urls = ["http://museus.cultura.gov.br/api/"]

view_type = "question"
metabase_graphics = [{'id':1, 'url':get_metabase_url(view_type, 18)},
                    {'id':2, 'url':get_metabase_url(view_type, 19)},
                    {'id':3, 'url':get_metabase_url(view_type, 20)},
                    {'id':4, 'url':get_metabase_url(view_type, 21)},
                    {'id':5, 'url':get_metabase_url(view_type, 22)},
                    {'id':6, 'url':get_metabase_url(view_type, 23)},
                    {'id':7, 'url':get_metabase_url(view_type, 24)}]

def index(request):
    return render(request, 'museums_indicators/museums_indicators.html', {'metabase_graphics':metabase_graphics})

def graphic_detail(request, graphic_id):
    graphic = metabase_graphics[int(graphic_id) - 1]
    return render(request,'museums_indicators/graphic_detail.html',{'graphic': graphic})

@task(name="populate_museum_data")
def populate_museum_data():
    if len(LastUpdateMuseumDate.objects) == 0:
        LastUpdateMuseumDate(DEFAULT_INITIAL_DATE).save()

    size = LastUpdateMuseumDate.objects.count()
    last_update = LastUpdateMuseumDate.objects[size - 1].create_date

    # parser_yaml = ParserYAML()
    # urls = parser_yaml.get_multi_instances_urls

    for url in urls:
        request = RequestMuseumRawData(last_update, url).data
        new_url = clean_url(url)
        for museum in request:
            date = museum["createTimestamp"]['date']
            MuseumData(new_url, str(museum["mus_tipo"]),
                       str(museum["mus_tipo_tematica"]),
                       str(museum["esfera"]),
                       str(museum["mus_servicos_visitaGuiada"]),
                       str(museum["mus_arquivo_acessoPublico"]), date).save()

    LastUpdateMuseumDate(str(datetime.now())).save()

from django.shortcuts import render
from quero_cultura.views import ParserYAML
from quero_cultura.views import get_metabase_url
from .api_connections import RequestProjectsRawData
from .models import LastUpdateProjectDate
from .models import ProjectData
from datetime import datetime
from celery.decorators import task
from quero_cultura.views import instaces_counter

DEFAULT_INITIAL_DATE = "2012-01-01 15:47:38.337553"

view_type = "question"
metabase_graphics = [{'id':1, 'url':get_metabase_url(view_type, 10)},
                    {'id':2, 'url':get_metabase_url(view_type, 11)},
                    {'id':3, 'url':get_metabase_url(view_type, 12)},
                    {'id':4, 'url':get_metabase_url(view_type, 13)}]


detailed_data = [{'id':1, 'url':get_metabase_url(view_type, 36)},
                {'id':2, 'url':get_metabase_url(view_type, 37)}]

instances_number = instaces_counter()
page_type = "Dados Projetos"
graphic_type = 'project_graphic_detail'

def index(request):
    return render(request, 'quero_cultura/indicators_page.html', {'metabase_graphics':metabase_graphics, 'instances_number':instances_number, 'detailed_data':detailed_data,'page_type':page_type, 'graphic_type':graphic_type})

def graphic_detail(request, graphic_id):
    graphic = metabase_graphics[int(graphic_id) - 1]
    return render(request,'project_indicators/graphic_detail.html',{'graphic': graphic})

@task(name="populate_project_data")
def populate_project_data():
    if len(LastUpdateProjectDate.objects) == 0:
        LastUpdateProjectDate(DEFAULT_INITIAL_DATE).save()

    size = LastUpdateProjectDate.objects.count()
    last_update = LastUpdateProjectDate.objects[size - 1].create_date

    parser_yaml = ParserYAML()
    urls = parser_yaml.get_multi_instances_urls

    for url in urls:
        request = RequestProjectsRawData(last_update, url).data
        new_url = clean_url(url)
        for project in request:
            date = project["createTimestamp"]['date']
            ProjectData(new_url, str(project['type']['name']),
                        str(project["useRegistrations"]), date).save()

    LastUpdateProjectDate(str(datetime.now())).save()


def clean_url(url):
    clean_url = url.replace(".", "")
    clean_url = clean_url.replace("http://", "")
    clean_url = clean_url.replace("/api/", "")

    return clean_url

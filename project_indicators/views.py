from django.shortcuts import render
from quero_cultura.views import ParserYAML
from quero_cultura.views import get_metabase_url
from .api_connections import RequestProjectsRawData
from .models import LastUpdateProjectDate
from .models import ProjectData
from datetime import datetime
from celery.decorators import task


DEFAULT_INITIAL_DATE = "2012-01-01 15:47:38.337553"

view_type = "question"
metabase_graphics = [{'id': 1, 'url': get_metabase_url(view_type, 10, "true")},
                     {'id': 2, 'url': get_metabase_url(view_type, 11, "true")},
                     {'id': 3, 'url': get_metabase_url(view_type, 12, "true")},
                     {'id': 4, 'url': get_metabase_url(view_type, 13, "true")}]


detailed_data = [{'id': 1, 'url': get_metabase_url("dashboard", 6, "false")}]


page_type = "Projetos"
graphic_type = 'project_graphic_detail'
page_descripition = "Projetos são leis de fomento, mostras, convocatórias e "\
                    + "editais criados pelas Secretarias de Cultura, além de "\
                    + "diversas iniciativas cadastradas pelos usuários da "\
                    + "plataforma"


def index(request):
    return render(request, 'quero_cultura/indicators_page.html',
                  {'metabase_graphics': metabase_graphics,
                   'detailed_data': detailed_data, 'page_type': page_type,
                   'graphic_type': graphic_type,
                   'page_descripition': page_descripition})


def graphic_detail(request, graphic_id):
    try:
        graphic = metabase_graphics[int(graphic_id) - 1]
    except IndexError:
        return render(request, 'quero_cultura/not_found.html')
    return render(request, 'quero_cultura/graphic_detail.html',
                  {'graphic': graphic})


@task(name="load_projects")
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
            if project["useRegistrations"] == True:
                project_use = 'Sim'
            elif project["useRegistrations"] == False:
                project_use = 'Não'
            ProjectData(new_url, str(project['type']['name']),
                        project_use, date).save()

    LastUpdateProjectDate(str(datetime.now())).save()


def clean_url(url):
    clean_url = url.replace(".", "")
    clean_url = clean_url.replace("http://", "")
    clean_url = clean_url.replace("/api/", "")

    return clean_url

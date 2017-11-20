from django.shortcuts import render
from quero_cultura.views import ParserYAML
from quero_cultura.views import get_metabase_url
from .api_connections import RequestProjectsRawData
from .models import LastUpdateProjectDate
from .models import ProjectData
from datetime import datetime
from celery.decorators import task

DEFAULT_INITIAL_DATE = "2012-01-01 15:47:38.337553"


def index(request):
    view_type = "question"

    url = {"graphic1": get_metabase_url(view_type, 10),
           "graphic2": get_metabase_url(view_type, 11),
           "graphic3": get_metabase_url(view_type, 12),
           "graphic4": get_metabase_url(view_type, 13)}

    return render(request, 'project_indicators/project-indicators.html', url)


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
            ProjectData(new_url, project['type']['name'],
                        str(project["useRegistrations"]), date).save()

    LastUpdateProjectDate(str(datetime.now())).save()


def clean_url(url):
    clean_url = url.replace(".", "")
    clean_url = clean_url.replace("http://", "")
    clean_url = clean_url.replace("/api/", "")

    return clean_url

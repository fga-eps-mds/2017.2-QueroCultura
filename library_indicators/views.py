from .api_connections import RequestLibraryRawData
from quero_cultura.views import ParserYAML
from quero_cultura.views import get_metabase_url
from project_indicators.views import clean_url
from .models import LibraryArea
from .models import LibraryData
from .models import LastUpdateLibraryDate
from datetime import datetime
from django.shortcuts import render
from celery.decorators import task

DEFAULT_INITIAL_DATE = "2012-01-01 15:47:38.337553"
urls = ["http://bibliotecas.cultura.gov.br/api/"]


def index(request):
    view_type = "question"

    url = {"graphic1": get_metabase_url(view_type, 25),
           "graphic2": get_metabase_url(view_type, 26),
           "graphic3": get_metabase_url(view_type, 27),
           "graphic4": get_metabase_url(view_type, 28),
           "graphic5": get_metabase_url(view_type, 29)}

    return render(request, 'library_indicators/library.html', url)


@task(name="populate_library_data")
def populate_library_data():
    if len(LastUpdateLibraryDate.objects) == 0:
        LastUpdateLibraryDate(DEFAULT_INITIAL_DATE).save()

    size = LastUpdateLibraryDate.objects.count()
    last_update = LastUpdateLibraryDate.objects[size - 1].create_date

    # parser_yaml = ParserYAML()
    # urls = parser_yaml.get_multi_instances_urls

    for url in urls:
        request = RequestLibraryRawData(last_update, url).data
        new_url = clean_url(url)
        for library in request:
            date = library["createTimestamp"]['date']
            LibraryData(new_url, str(library['esfera']),
                        str(library['esfera_tipo']), date).save()
            for area in library["terms"]["area"]:
                LibraryArea(new_url, area).save()

    LastUpdateLibraryDate(str(datetime.now())).save()

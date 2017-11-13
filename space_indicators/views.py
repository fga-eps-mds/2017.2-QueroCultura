from datetime import datetime
from django.shortcuts import render
from .api_connections import RequestSpacesRawData
from .models import SpaceData
from .models import LastUpdateDate
from project_indicators.views import clean_url
from quero_cultura.views import ParserYAML
from celery.decorators import task
import jwt

METABASE_SITE_URL = "http://0.0.0.0:3000"
METABASE_SECRET_KEY = "1798c3ba25f5799bd75538a7fe2896b79e24f3ec1df9d921558899dc690bbcd9"
DEFAULT_INITIAL_DATE = "2012-01-01 00:00:00.000000"


def index(request):
    payload = {"resource": {"dashboard": 1},
               "params": {}}

    token = jwt.encode(payload, METABASE_SECRET_KEY, algorithm='HS256')
    token = str(token).replace("b'", "")
    token = token.replace("'", "")

    i_frame_url = METABASE_SITE_URL + "/embed/dashboard/" + token + "#bordered=true&titled=true"
    url = {"url": i_frame_url}
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

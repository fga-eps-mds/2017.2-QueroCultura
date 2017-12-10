from django.shortcuts import render
from .models import AgentsArea
from .models import AgentsData
from .models import LastUpdateAgentsDate
from .api_connection import EmptyRequest
from .api_connection import RequestAgentsInPeriod
from .api_connection import RequestAgentsRawData
from project_indicators.views import clean_url
from quero_cultura.views import ParserYAML
from quero_cultura.views import get_metabase_url
from datetime import datetime
from celery.decorators import task


DEFAULT_INITIAL_DATE = "2012-01-01 00:00:00.000000"
SP_URL = "http://spcultura.prefeitura.sp.gov.br/api/"
DEFAULT_YEAR = 2013
CURRENT_YEAR = datetime.today().year + 1

# Get graphics urls from metabase
# To add new graphis, just add in the metabase_graphics variable
view_type = "question"
metabase_graphics = [{'id': 1, 'url': get_metabase_url(view_type, 30, "true")},
                     {'id': 2, 'url': get_metabase_url(view_type, 31, "true")},
                     {'id': 3, 'url': get_metabase_url(view_type, 32, "true")},
                     {'id': 4, 'url': get_metabase_url(view_type, 33, "true")}]

detailed_data = [{'id': 1, 'url': get_metabase_url(view_type, 34, "false")},
                 {'id': 2, 'url': get_metabase_url(view_type, 35, "false")},
                 {'id': 3, 'url': get_metabase_url(view_type, 44, "false")}]


page_type = "Agentes"
graphic_type = 'agents_graphic_detail'
page_descripition = 'Agentes são artistas, gestores, produtores e'\
                   + 'instituições juntos eles formam uma rede de atores '\
                   + 'envolvidos na cena cultural brasileira, nos gráficos '\
                   + 'abaixo geramos indicadores visando extrair informações'\
                   + ' úteis ao MinC e a população em geral sobre os Agentes '\
                   + 'culturais da plataforma'

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
      return render(request,
                  'quero_cultura/not_found.html')
    return render(request,
                  'quero_cultura/graphic_detail.html', {'graphic': graphic})


@task(name="load_agents")
def populate_agent_data():
    if len(LastUpdateAgentsDate.objects) == 0:
        LastUpdateAgentsDate(DEFAULT_INITIAL_DATE).save()

    size = LastUpdateAgentsDate.objects.count()
    last_update = LastUpdateAgentsDate.objects[size - 1].create_date

    parser_yaml = ParserYAML()
    urls = parser_yaml.get_multi_instances_urls

    for url in urls:
        if url == SP_URL:
            request = EmptyRequest()
            for year in range(DEFAULT_YEAR, CURRENT_YEAR):
                single_request = RequestAgentsInPeriod(year, url)
                request.data += single_request.data
            request = request.data
        else:
            request = RequestAgentsRawData(last_update, url).data

        new_url = clean_url(url)

        for agent in request:
            date = agent["createTimestamp"]['date']
            AgentsData(new_url, str(agent['type']['name']), date).save()
            for area in agent["terms"]["area"]:
                AgentsArea(new_url, area).save()
    LastUpdateAgentsDate(str(datetime.now())).save()

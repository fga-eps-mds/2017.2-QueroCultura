from .api_connection import RequestAgentsRawData
from .api_connection import RequestAgentsInPeriod
from .api_connection import EmptyRequest
from django.shortcuts import render
from .models import PercentIndividualAndCollectiveAgent
from .models import AmountAgentsRegisteredPerMonth
from .models import PercentAgentsPerAreaOperation
from datetime import datetime
import json
from celery.decorators import task
from quero_cultura.views import build_temporal_indicator
from quero_cultura.views import build_operation_area_indicator
from quero_cultura.views import sort_dict

DEFAULT_INITIAL_DATE = "2012-01-01 00:00:00.000000"

def index(request):

    # Retorna na variavel index a quantidade de registros existentes
    index = PercentIndividualAndCollectiveAgent.objects.count()

    # Usa o valor de index para acessar elementos no BD pelo indice
    per_type = PercentIndividualAndCollectiveAgent.objects[index-1]
    per_area = PercentAgentsPerAreaOperation.objects[index-1]
    temporal = AmountAgentsRegisteredPerMonth.objects[index-1]

    # Atribui as variaveis valores para apresentação dos indicadores
    per_area = per_area.total_agents_area_oreration
    temporal = temporal.total_agents_registered_month

    # Prepara visualização do indicador por tipo
    total_per_type = per_type.total_individual_agent
    total_per_type += per_type.total_collective_agent
    percent_indivividual = per_type.total_individual_agent/total_per_type * 100
    percent_collective = per_type.total_collective_agent / total_per_type * 100
    per_type_keys = ["Individual", "Coletivo"]
    per_type_values = [round(percent_indivividual, 2), round(percent_collective, 2)]

    # Inicializa variaveis com listas vazias
    per_area_keys = []
    per_area_values = []
    per_area = sort_dict(per_area)

    # Prepara visualização do indicador por area de atuação
    for area in per_area:
        if area == area.capitalize():
            per_area_keys.append(area)
            per_area_values.append(per_area[area])

    # Inicializa variaveis que auxiliam na preparação do indicador temporal
    months = ["01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12"]
    last_year = 2013 + len(temporal)
    growthing = 0

    temporal_keys = []
    temporal_values = []
    temporal_growth = []

    # Prepara visualização do indicador temporal
    for year in range(2013, last_year):
        for month in months:
            if (month in temporal[str(year)]):
                temporal_keys.append(str(year) + "-" + month)
                temporal_values.append(temporal[str(year)][month])

                growthing += temporal[str(year)][month]
                temporal_growth.append(growthing)

    # Cria dicionario para apresentação dos graficos de indicadores
    context = {
        'per_area_keys': json.dumps(per_area_keys),
        'per_area_values': json.dumps(per_area_values),
        'per_type_keys': json.dumps(per_type_keys),
        'per_type_values': json.dumps(per_type_values),
        'temporal_keys': json.dumps(temporal_keys),
        'temporal_values': json.dumps(temporal_values),
        'temporal_growth': json.dumps(temporal_growth),
    }

    # Renderiza pagina e envia dicionario para apresentação dos graficos
    return render(request, 'agents_indicators/agents-indicators.html', context)


def build_type_indicator(new_data):
    per_type = {}

    for agent in new_data:
        if not (agent["type"]["name"] in per_type):
            per_type[agent["type"]["name"]] = 1
        else:
            per_type[agent["type"]["name"]] += 1

    return per_type


@task(name="load_agents")
def update_agent_indicator():
    url = "http://spcultura.prefeitura.sp.gov.br/api/"

    # Cria registro inicial caso seja o primeiro uso da aplicação
    if len(PercentIndividualAndCollectiveAgent.objects) == 0:
        PercentIndividualAndCollectiveAgent(0, DEFAULT_INITIAL_DATE, 0, 0).save()
        PercentAgentsPerAreaOperation(0, DEFAULT_INITIAL_DATE, {"Literatura": 0}).save()
        AmountAgentsRegisteredPerMonth({"2015": {"01": 0}}, DEFAULT_INITIAL_DATE).save()

    # Retorna na variavel index a quantidade de registros existentes
    index = PercentAgentsPerAreaOperation.objects.count()

    # Usa o valor de index para acessar elementos no BD pelo indice
    last_per_area = PercentAgentsPerAreaOperation.objects[index-1]
    last_type = PercentIndividualAndCollectiveAgent.objects[index-1]
    last_temporal = AmountAgentsRegisteredPerMonth.objects[index-1]

    # Requisita dados da API MinC a partir de data passada por parmetro
    if(last_per_area.create_date == DEFAULT_INITIAL_DATE):
        this_year = datetime.today().year

        # DEFAULT_INITIAL_DATE.year
        default_year = 2012
        request = EmptyRequest()
        for year in range(default_year, this_year+1):
            single_request = RequestAgentsInPeriod(year, url)
            request.data += single_request.data

        print(request.data_length)
    else:
        request = RequestAgentsRawData(last_per_area.create_date, url)

    # Geração indicadores de agentes atualizados
    new_total = request.data_length + last_per_area.total_agents
    new_create_date = datetime.now().__str__()

    new_per_area = build_operation_area_indicator(request.data, last_per_area.total_agents_area_oreration)
    new_per_month = build_temporal_indicator(request.data, last_temporal.total_agents_registered_month)
    new_type = build_type_indicator(request.data)

    if "Individual" in new_type:
        new_individual = last_type.total_individual_agent + new_type["Individual"]
    else:
        new_individual = last_type.total_individual_agent

    if "Coletivo" in new_type:
        new_collective = last_type.total_collective_agent + new_type["Coletivo"]
    else:
        new_collective = last_type.total_collective_agent

    # Persistencia de indicadores de agentes atualizados
    AmountAgentsRegisteredPerMonth(new_per_month, new_create_date).save()
    PercentIndividualAndCollectiveAgent(new_total, new_create_date, new_individual, new_collective).save()
    PercentAgentsPerAreaOperation(new_total, new_create_date, new_per_area).save()

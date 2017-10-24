from .api_connection import RequestAgentsRawData
from django.shortcuts import render
from .models import PercentIndividualAndCollectiveAgent
from .models import AmountAgentsRegisteredPerMonth
from .models import PercentAgentsPerAreaOperation
from datetime import datetime
import json


def index(request):
    # Codigo que dropa a base de dados

    # PercentAgentsPerAreaOperation.drop_collection()
    # PercentIndividualAndCollectiveAgent.drop_collection()
    # AmountAgentsRegisteredPerMonth.drop_collection()

    # Codigo provisorio de atulização do BD - Celery fara as atualizações
    
    # update_agent_indicator("http://mapas.cultura.gov.br/api/agent/find/")

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
    per_type_keys = ["Individual", "Coletivo"]
    per_type_values = [per_type.total_individual_agent, per_type.total_collective_agent]

    # Inicializa variaveis com listas vazias
    per_area_keys = []
    per_area_values = []

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
    return render(request, 'agents_indicators/index.html', context)


def build_temporal_indicator(new_data, old_data):
    temporal_indicator = {}

    for agent in new_data:
        split_date = agent["createTimestamp"]["date"].split("-")

        year = split_date[0]
        month = split_date[1]

        if not (year in temporal_indicator):
            temporal_indicator[year] = {}
            temporal_indicator[year][month] = 1
        elif not (month in temporal_indicator.get(year)):
            temporal_indicator[year][month] = 1
        else:
            temporal_indicator[year][month] += 1

    for year in old_data:
        if not (year in temporal_indicator):
            temporal_indicator[year] = old_data[year]
        else:
            for month in old_data[year]:
                if not (month in temporal_indicator[year]):
                    temporal_indicator[year][month] = old_data[year][month]
                else:
                    temporal_indicator[year][month] += old_data[year][month]

    return temporal_indicator


def build_type_indicator(new_data):
    per_type = {}

    for agent in new_data:
        if not (agent["type"]["name"] in per_type):
            per_type[agent["type"]["name"]] = 1
        else:
            per_type[agent["type"]["name"]] += 1

    return per_type


def build_operation_area_indicator(new_data, old_data):
    per_operation_area = {}

    for agent in new_data:
        for area in agent["terms"]["area"]:
            if not (area in per_operation_area):
                per_operation_area[area] = 1
            else:
                per_operation_area[area] += 1

    for area in old_data:
            if not (area in per_operation_area):
                per_operation_area[area] = old_data[area]
            else:
                per_operation_area[area] += old_data[area]

    return per_operation_area


def update_agent_indicator(url):

    # Cria registro inicial caso seja o primeiro uso da aplicação
    if len(PercentIndividualAndCollectiveAgent.objects) == 0:
        PercentIndividualAndCollectiveAgent(0, "2012-01-01 15:47:38.337553", 0, 0).save()
        PercentAgentsPerAreaOperation(0, "2012-01-01 15:47:38.337553", {"Literatura": 0}).save()
        AmountAgentsRegisteredPerMonth({"2015": {"01": 0}}, "2012-01-01 15:47:38.337553").save()

    # Retorna na variavel index a quantidade de registros existentes
    index = PercentAgentsPerAreaOperation.objects.count()

    # Usa o valor de index para acessar elementos no BD pelo indice
    last_per_area = PercentAgentsPerAreaOperation.objects[index-1]
    last_type = PercentIndividualAndCollectiveAgent.objects[index-1]
    last_temporal = AmountAgentsRegisteredPerMonth.objects[index-1]

    # Requisita dados da API MinC a partir de data passada por parmetro
    request = RequestAgentsRawData(last_per_area.create_date, url)

    # Geração indicadores de agentes atualizados
    new_total = request.data_length + last_per_area.total_agents
    new_create_date = datetime.now().__str__()

    new_per_area = build_operation_area_indicator(request.data, last_per_area.total_agents_area_oreration)
    new_per_month = build_temporal_indicator(request.data, last_temporal.total_agents_registered_month)
    new_type = build_type_indicator(request.data)

    new_individual = last_type.total_individual_agent + new_type["Individual"]
    new_collective = last_type.total_collective_agent + new_type["Coletivo"]

    # Persistencia de indicadores de agentes atualizados
    AmountAgentsRegisteredPerMonth(new_per_month, new_create_date).save()
    PercentIndividualAndCollectiveAgent(new_total, new_create_date, new_individual, new_collective).save()
    PercentAgentsPerAreaOperation(new_total, new_create_date, new_per_area).save()

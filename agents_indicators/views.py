from .api_connection import RequestAgentsRawData
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

DEFAULT_INITIAL_DATE = "2012-01-01 15:47:38.337553"
def index(request):

    # return index of amount exist register
    index = PercentIndividualAndCollectiveAgent.objects.count()

    # Use the index value to access elements in the DB by the index
    per_type = PercentIndividualAndCollectiveAgent.objects[index-1]
    per_area = PercentAgentsPerAreaOperation.objects[index-1]
    temporal = AmountAgentsRegisteredPerMonth.objects[index-1]

    # Assigns the variable values ​​for the presentation of the indicators
    per_area = per_area.total_agents_area_oreration
    temporal = temporal.total_agents_registered_month

    # Prepares visualization of the indicator by type
    total_per_type = per_type.total_individual_agent
    total_per_type += per_type.total_collective_agent
    percent_indivividual = per_type.total_individual_agent/total_per_type * 100
    percent_collective = per_type.total_collective_agent / total_per_type * 100
    per_type_keys = ["Individual", "Coletivo"]
    per_type_values = [round(percent_indivividual, 2), round(percent_collective, 2)]


    # Initializes variables with empty lists
    per_area_keys = []
    per_area_values = []
    per_area = sort_dict(per_area)

    # Prepares visualization of the indicator by actuation area
    for area in per_area:
        if area == area.capitalize():
            per_area_keys.append(area)
            per_area_values.append(per_area[area])

    # Initializes variables that help in the preparation of the temporal indicator
    months = ["01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12"]
    last_year = 2013 + len(temporal)
    growthing = 0

    temporal_keys = []
    temporal_values = []
    temporal_growth = []

    #Use this just for see values on html
    s = {}
    get_subsite(s)

    # Prepares visualization of the temporal indicator
    for year in range(2013, last_year):
        for month in months:
            if (month in temporal[str(year)]):
                temporal_keys.append(str(year) + "-" + month)
                temporal_values.append(temporal[str(year)][month])

                growthing += temporal[str(year)][month]
                temporal_growth.append(growthing)

    # Creates a dictionary for displaying graphs of indicators
    context = {
        'per_area_keys': json.dumps(per_area_keys),
        'per_area_values': json.dumps(per_area_values),
        'per_type_keys': json.dumps(per_type_keys),
        'per_type_values': json.dumps(per_type_values),
        'temporal_keys': json.dumps(temporal_keys),
        'temporal_values': json.dumps(temporal_values),
        'temporal_growth': json.dumps(temporal_growth),
        'teste': s
    }


    return render(request, 'agents_indicators/agents-indicators.html', context)


def build_type_indicator(new_data):
    per_type = {}

    for agent in new_data:
        if not (agent["type"]["name"] in per_type):
            per_type[agent["type"]["name"]] = 1
        else:
            per_type[agent["type"]["name"]] += 1

    return per_type

def get_agents_cultural_maps():
    values = RequestAgentsRawData(DEFAULT_INITIAL_DATE, "http://mapas.cultura.gov.br/api/")
    return values.data

def get_agents_ce_cultural():
    values = RequestAgentsRawData(DEFAULT_INITIAL_DATE, "http://mapa.cultura.ce.gov.br/api/")
    return values.data

def get_subsite(dict_instances):

    for instance in get_agents_cultural_maps():
        filter_subsite_instances(dict_instances, instance["subsite"])

def get_instance(index):
    instances_cultural_map = [
        {"id":1,"instancia": "mapas_museus"},
        {"id":2,"instancia": "mapas_bibliotecas"},
        {"id":4,"instancia": "mapas_culturais"},
        {"id":9,"instancia": "mapas_espirito_santo"},
        {"id":11,"instancia": "mapas_paraiba"},
        {"id":12,"instancia": "mapas_maranhão"},
        {"id":15,"instancia": "mapas_pará"},
        {"id":16,"instancia": "mapas_jaguarao"},
        {"id":17,"instancia": "mapas_meleva"},
        {"id":18,"instancia": "mapas_grucultura"},
        {"id":20,"instancia": "mapas_laguna"},
        {"id":21,"instancia": "mapas_aracaju"},
        {"id":22,"instancia": "mapas_francodarocha"},
        {"id":23,"instancia": "mapas_itu"},
        {"id":24,"instancia": "mapas_ba"},
        {"id":25,"instancia": "mapas_parnaiba"},
        {"id":26,"instancia": "mapas_osasco"},
        {"id":27,"instancia": "mapas_camacari"},
        {"id":28,"instancia": "mapas_ilheus"},
        {"id":29,"instancia": "mapas_varzeagrande"},
        {"id":30,"instancia": "mapas_pontosdememoria"},
        {"id":31,"instancia": "mapas_foz"},
        {"id":32,"instancia": "mapas_senhordobonfim"},
        {"id":33,"instancia": "mapas_sergipe"},
        {"id":34,"instancia": "mapas_itapetininga"},
        {"id":35,"instancia": "mapas_ipatinga"},
        {"id":36,"instancia": "mapas_novohamburgo"},
        {"id":37,"instancia": "mapas_saocaetanodosul"}
    ]
    for i in instances_cultural_map:
        if(i["id"] == index):
            return i["instancia"]
        else:
            pass
    return ""

def filter_subsite_instances(dict_instances,id_instance):
    instance = get_instance(id_instance)
    if  not(instance in dict_instances):
        dict_instances[instance] = 1
    else :
        dict_instances[instance] += 1



@task(name="update_agent_indicator")
def update_agent_indicator():
    url = "http://mapas.cultura.gov.br/api/"

    # Creates initial registration if it is the first use of the application
    if len(PercentIndividualAndCollectiveAgent.objects) == 0:
        PercentIndividualAndCollectiveAgent(0, DEFAULT_INITIAL_DATE, 0, 0).save()
        PercentAgentsPerAreaOperation(0, DEFAULT_INITIAL_DATE, {"Literatura": 0}).save()
        AmountAgentsRegisteredPerMonth({"2015": {"01": 0}}, DEFAULT_INITIAL_DATE).save()

    # Returns in the variable index the number of existing records
    index = PercentAgentsPerAreaOperation.objects.count()

    # Use the index value to access elements in the DB by the index
    last_per_area = PercentAgentsPerAreaOperation.objects[index-1]
    last_type = PercentIndividualAndCollectiveAgent.objects[index-1]
    last_temporal = AmountAgentsRegisteredPerMonth.objects[index-1]

    # Requires MinC API data from date passed by parameter
    request = RequestAgentsRawData(last_per_area.create_date, url)


    # Generating Updated Agent Indicators
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

    # Persistence of Updated Agent Indicators
    AmountAgentsRegisteredPerMonth(new_per_month, new_create_date).save()
    PercentIndividualAndCollectiveAgent(new_total, new_create_date, new_individual, new_collective).save()
    PercentAgentsPerAreaOperation(new_total, new_create_date, new_per_area).save()

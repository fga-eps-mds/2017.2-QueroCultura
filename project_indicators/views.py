from django.shortcuts import render
from quero_cultura.views import build_temporal_indicator
from .models import PercentProjectPerType
from .models import PercentProjectThatAcceptOnlineTransitions
from .models import QuantityOfRegisteredProject
from .api_connections import RequestProjectsRawData
from datetime import datetime
from celery.decorators import task
import yaml
import json


DEFAULT_INITIAL_DATE = "2012-01-01 15:47:38.337553"

def index(request):
    update_project_indicator()
    index = PercentProjectPerType.objects.count()
    per_type = PercentProjectPerType.objects[index - 1]
    print(per_type.total_project_per_type)
    # Cria dicionario para apresentação dos graficos de indicadores
    context = {}

    # Renderiza pagina e envia dicionario para apresentação dos graficos
    return render(request, 'project_indicators/project-indicators.html', context)


def build_type_indicator(new_data, old_data):
    per_type = {}

    for project in new_data:
        if not (project["type"]["name"] in per_type):
            per_type[project["type"]["name"]] = 1
        else:
            per_type[project["type"]["name"]] += 1

    for project in old_data:
        if not (project in per_type):
            per_type[project] = old_data[project]
        else:
            per_type[project] += old_data[project]

    return per_type


def build_online_record_indicator(new_data, old_data):
    per_online_record = {}

    for project in new_data:
        if not (str(project["useRegistrations"]) in per_online_record):
            per_online_record[str(project["useRegistrations"])] = 1
        else:
            per_online_record[str(project["useRegistrations"])] += 1

    for project in old_data:
        if not (project in per_online_record):
            per_online_record[project] = old_data[project]
        else:
            per_online_record[project] += old_data[project]

    return per_online_record


def update_project_indicator():
    if len(PercentProjectPerType.objects) == 0:
        PercentProjectPerType(0, DEFAULT_INITIAL_DATE, {'http://mapas.cultura.gov.br/api/': {'Exposição': 0}}).save()
        PercentProjectThatAcceptOnlineTransitions(0, DEFAULT_INITIAL_DATE, {'http://mapas.cultura.gov.br/api/': {'True': 0, 'False': 0}}).save()
        QuantityOfRegisteredProject(0, DEFAULT_INITIAL_DATE, {'http://mapas.cultura.gov.br/api/': {'2015': {'01': 0}}}).save()

    index = PercentProjectPerType.objects.count()

    last_per_Type = PercentProjectPerType.objects[index - 1]
    last_per_online_record = PercentProjectThatAcceptOnlineTransitions.objects[index - 1]
    last_temporal = QuantityOfRegisteredProject.objects[index - 1]

    urls_files = open('./urls.yaml', 'r')
    urls = yaml.load(urls_files)

    new_per_type = last_per_Type.total_project_per_type
    new_per_online = last_per_online_record.total_project_that_accept_online_transitions
    new_temporal = last_temporal.total_project_registered_per_mounth_per_year

    new_total = last_per_Type.total_project

    for url in urls:
        request = RequestProjectsRawData(last_per_Type.create_date, url)
        new_total += request.data_length

        if not(url in new_per_type):
            new_per_type[url] = build_type_indicator(request.data, {})
        else:
            new_per_type[url] = build_type_indicator(request.data, new_per_type[url])

        if not(url in new_per_online):
            new_per_online[url] = build_online_record_indicator(request.data, {})
        else:
            new_per_online[url] = build_online_record_indicator(request.data, new_per_online[url])

        if not(url in new_temporal):
            new_temporal[url] = build_temporal_indicator(request.data, {})
        else:
            new_temporal[url] = build_temporal_indicator(request.data, new_temporal[url])

    new_create_date = str(datetime.now())

    PercentProjectPerType(new_total, new_create_date, new_per_type).save()
    PercentProjectThatAcceptOnlineTransitions(new_total, new_create_date, new_per_online).save()
    QuantityOfRegisteredProject(new_total, new_create_date, new_temporal).save()

from django.shortcuts import render
from quero_cultura.views import build_temporal_indicator
from quero_cultura.views import sort_dict
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

    # load indicators
    per_type = PercentProjectPerType.objects[index - 1]
    per_online = PercentProjectThatAcceptOnlineTransitions.objects[index - 1]
    temporal = QuantityOfRegisteredProject.objects[index - 1]

    per_type = per_type.total_project_per_type
    per_online = per_online.total_project_that_accept_online_transitions
    temporal = temporal.total_project_registered_per_mounth_per_year

    per_type = prepare_indicator_list(per_type, 'per_type')
    per_online = prepare_indicator_list(per_online, 'per_online')
    temporal = prepare_temporal_vision(temporal)

    # Cria dicionario para apresentação dos graficos de indicadores
    context = {}
    urls_files = open('./urls.yaml', 'r')
    urls = yaml.load(urls_files)

    for url in urls:
        new_url = url.replace(".", "")
        clean_url = new_url.replace("http://", "")
        clean_url = clean_url.replace("/api/", "")

        context['keys_per_type_' + clean_url] = json.dumps(per_type['keys_per_type_' + new_url])
        context['values_per_type_' + clean_url] = json.dumps(per_type['values_per_type_' + new_url])

        context['keys_per_online_' + clean_url] = json.dumps(per_online['keys_per_online_' + new_url])
        context['values_per_online_' + clean_url] = json.dumps(per_online['values_per_online_' + new_url])

        context['keys_temporal_' + clean_url] = json.dumps(temporal['keys_temporal_' + new_url])
        context['values_temporal_' + clean_url] = json.dumps(temporal['values_temporal_' + new_url])
        context['growth_temporal_' + clean_url] = json.dumps(temporal['growth_temporal_' + new_url])



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
        PercentProjectPerType(0, DEFAULT_INITIAL_DATE, {'http://mapasculturagovbr/api/': {'Exposição': 0}}).save()
        PercentProjectThatAcceptOnlineTransitions(0, DEFAULT_INITIAL_DATE, {'http://mapasculturagovbr/api/': {'True': 0, 'False': 0}}).save()
        QuantityOfRegisteredProject(0, DEFAULT_INITIAL_DATE, {'http://mapasculturagovbr/api/': {'2015': {'01': 0}}}).save()

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

        mongo_url = url.replace(".", "")

        if not(mongo_url in new_per_type):
            new_per_type[mongo_url] = build_type_indicator(request.data, {})
            new_per_online[mongo_url] = build_online_record_indicator(request.data, {})
            new_temporal[mongo_url] = build_temporal_indicator(request.data, {})
        else:
            new_per_type[mongo_url] = build_type_indicator(request.data, new_per_type[mongo_url])
            new_per_online[mongo_url] = build_online_record_indicator(request.data, new_per_online[mongo_url])
            new_temporal[mongo_url] = build_temporal_indicator(request.data, new_temporal[mongo_url])

    new_create_date = str(datetime.now())

    PercentProjectPerType(new_total, new_create_date, new_per_type).save()
    PercentProjectThatAcceptOnlineTransitions(new_total, new_create_date, new_per_online).save()
    QuantityOfRegisteredProject(new_total, new_create_date, new_temporal).save()


def prepare_temporal_vision(temporal):
    months = ["01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12"]
    prepared_temporal = {}

    for url in temporal:
        first_year = int(min(temporal[url].keys()))
        last_year = int(max(temporal[url].keys())) + 1
        growthing = 0

        temporal_keys = []
        temporal_values = []
        temporal_growth = []

        for year in range(first_year, last_year):
            for month in months:
                if (month in temporal[url][str(year)]):
                    temporal_keys.append(str(year) + "-" + month)
                    temporal_values.append(temporal[url][str(year)][month])

                    growthing += temporal[url][str(year)][month]
                    temporal_growth.append(growthing)

        prepared_temporal["keys_temporal_"+url] = temporal_keys
        prepared_temporal["values_temporal_"+url] = temporal_values
        prepared_temporal["growth_temporal_"+url] = temporal_growth

    return prepared_temporal


def prepare_indicator_list(indicator, indicator_name):
    sort_indicator = {}
    prepared_indicator = {}

    for url in indicator:
        sort_indicator = sort_dict(indicator[url])
        keys = []
        values = []
        for key in sort_indicator:
            keys.append(key)
            values.append(sort_indicator[key])

        prepared_indicator['keys_' + indicator_name + '_' + url] = keys
        prepared_indicator['values_' + indicator_name + '_' + url] = values

    return prepared_indicator

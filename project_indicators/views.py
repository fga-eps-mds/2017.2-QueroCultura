from django.shortcuts import render
from quero_cultura.views import build_temporal_indicator
from quero_cultura.views import build_simple_indicator
from quero_cultura.views import build_compound_indicator
from quero_cultura.views import merge_indicators
from quero_cultura.views import sort_dict
from quero_cultura.views import ParserYAML
from .models import PercentProjectPerType
from .models import PercentProjectThatAcceptOnlineTransitions
from .models import QuantityOfRegisteredProject
from .api_connections import RequestProjectsRawData
from datetime import datetime
from celery.decorators import task
import json

DEFAULT_INITIAL_DATE = "2012-01-01 15:47:38.337553"


def index(request):
    per_type, per_online, temporal = load_last_registers()

    per_type = per_type.total_project_per_type
    per_online = per_online.total_project_that_accept_online_transitions
    temporal = temporal.total_project_registered_per_mounth_per_year

    total_per_type = create_dict(per_type["mapasculturagovbr"])
    total_per_type = merge_indicators(total_per_type, per_type["mapaculturacegovbr"])
    total_per_type = merge_indicators(total_per_type, per_type["spculturaprefeituraspgovbr"])
    total_per_type = prepare_single_indicator_list(total_per_type, "total_per_type")

    total_per_online = create_dict(per_online["mapasculturagovbr"])
    total_per_online = merge_indicators(total_per_online, per_online["mapaculturacegovbr"])
    total_per_online = merge_indicators(total_per_online, per_online["spculturaprefeituraspgovbr"])
    total_per_online = prepare_single_indicator_list(total_per_online, "total_per_online")

    total_temporal = create_temporal_dict(temporal["mapasculturagovbr"])
    total_temporal = merge_temporal_indicators(total_temporal, temporal["mapaculturacegovbr"])
    total_temporal = merge_temporal_indicators(total_temporal, temporal["spculturaprefeituraspgovbr"])
    total_temporal = prepare_single_temporal_vision(total_temporal)

    # prepare indicators
    per_type = prepare_indicator_list(per_type, 'per_type')
    per_online = prepare_indicator_list(per_online, 'per_online')
    temporal = prepare_temporal_vision(temporal)

    # create context
    context = {
        'keys_per_type': json.dumps(per_type['keys_per_type']),
        'values_per_type': json.dumps(per_type['values_per_type']),
        'keys_per_online': json.dumps(per_online['keys_per_online']),
        'values_per_online': json.dumps(per_online['values_per_online']),
        'keys_temporal': json.dumps(temporal['keys_temporal']),
        'values_temporal': json.dumps(temporal['values_temporal']),
        'growth_temporal': json.dumps(temporal['growth_temporal']),
        'keys_total_per_type': json.dumps(total_per_type['keys_total_per_type']),
        'values_total_per_type': json.dumps(total_per_type['values_total_per_type']),
        'keys_total_per_online': json.dumps(total_per_online['keys_total_per_online']),
        'values_total_per_online': json.dumps(total_per_online['values_total_per_online']),
        'keys_total_temporal': json.dumps(total_temporal['keys_total_temporal']),
        'values_total_temporal': json.dumps(total_temporal['values_total_temporal']),
        'growth_total_temporal': json.dumps(total_temporal['growth_total_temporal']),
    }

    # Renderiza pagina e envia dicionario para apresentação dos graficos
    return render(request, 'project_indicators/project-indicators.html', context)


def load_last_registers():
    index = PercentProjectPerType.objects.count()

    last_per_type = PercentProjectPerType.objects[index - 1]
    last_per_online = PercentProjectThatAcceptOnlineTransitions.objects[index - 1]
    last_temporal = QuantityOfRegisteredProject.objects[index - 1]

    return last_per_type, last_per_online, last_temporal


@task(name="update_project_indicator")
def update_project_indicator():
    if len(PercentProjectPerType.objects) == 0:
        PercentProjectPerType(0, DEFAULT_INITIAL_DATE, {'mapasculturagovbr': {'Exposição': 0}}).save()
        PercentProjectThatAcceptOnlineTransitions(0, DEFAULT_INITIAL_DATE, {'mapasculturagovbr': {'True': 0, 'False': 0}}).save()
        QuantityOfRegisteredProject(0, DEFAULT_INITIAL_DATE, {'mapasculturagovbr': {'2015': {'01': 0}}}).save()

    last_per_type, last_per_online, last_temporal = load_last_registers()

    new_total = last_per_type.total_project
    last_update_date = last_per_type.create_date

    parser_yaml = ParserYAML()
    urls = parser_yaml.get_multi_instances_urls

    last_per_type = last_per_type.total_project_per_type
    last_per_online = last_per_online.total_project_that_accept_online_transitions
    new_temporal = last_temporal.total_project_registered_per_mounth_per_year

    new_per_type = {}
    new_per_online = {}

    for url in urls:
        request = RequestProjectsRawData(last_update_date, url)
        new_total += request.data_length

        mongo_url = clean_url(url)

        new_per_type[mongo_url] = build_compound_indicator(request.data, "type", "name")
        new_per_online[mongo_url] = build_simple_indicator(request.data, "useRegistrations")

        if not(mongo_url in new_temporal):
            new_temporal[mongo_url] = build_temporal_indicator(request.data, {})
        else:
            new_per_type[mongo_url] = merge_indicators(new_per_type[mongo_url], last_per_type[mongo_url])
            new_per_online[mongo_url] = merge_indicators(new_per_online[mongo_url], last_per_online[mongo_url])
            new_temporal[mongo_url] = build_temporal_indicator(request.data, new_temporal[mongo_url])

    new_create_date = str(datetime.now())

    PercentProjectPerType(new_total, new_create_date, new_per_type).save()
    PercentProjectThatAcceptOnlineTransitions(new_total, new_create_date, new_per_online).save()
    QuantityOfRegisteredProject(new_total, new_create_date, new_temporal).save()


def clean_url(url):
    clean_url = url.replace(".", "")
    clean_url = clean_url.replace("http://", "")
    clean_url = clean_url.replace("/api/", "")

    return clean_url


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

        prepared_temporal["keys_temporal"] = {}
        prepared_temporal["values_temporal"] = {}
        prepared_temporal["growth_temporal"] = {}

        for year in range(first_year, last_year):
            for month in months:
                if (month in temporal[url][str(year)]):
                    temporal_keys.append(str(year) + "-" + month)
                    temporal_values.append(temporal[url][str(year)][month])

                    growthing += temporal[url][str(year)][month]
                    temporal_growth.append(growthing)

        prepared_temporal["keys_temporal"][url] = temporal_keys
        prepared_temporal["values_temporal"][url] = temporal_values
        prepared_temporal["growth_temporal"][url] = temporal_growth

    return prepared_temporal


def prepare_indicator_list(indicator, indicator_name):
    sort_indicator = {}
    prepared_indicator = {}

    prepared_indicator['keys_' + indicator_name] = {}
    prepared_indicator['values_' + indicator_name] = {}

    for url in indicator:
        sort_indicator = sort_dict(indicator[url])
        keys = []
        values = []

        for key in sort_indicator:
            keys.append(key)
            values.append(sort_indicator[key])

        prepared_indicator['keys_' + indicator_name][url] = keys
        prepared_indicator['values_' + indicator_name][url] = values

    return prepared_indicator

# This methods are temporary


def merge_temporal_indicators(indicator, old_data):
    temporal_indicator = indicator

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


def prepare_single_temporal_vision(temporal):
    months = ["01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12"]
    prepared_temporal = {}

    first_year = int(min(temporal.keys()))
    last_year = int(max(temporal.keys())) + 1
    growthing = 0

    temporal_keys = []
    temporal_values = []
    temporal_growth = []

    for year in range(first_year, last_year):
        for month in months:
            if (month in temporal[str(year)]):
                temporal_keys.append(str(year) + "-" + month)
                temporal_values.append(temporal[str(year)][month])

                growthing += temporal[str(year)][month]
                temporal_growth.append(growthing)

    prepared_temporal["keys_total_temporal"] = temporal_keys
    prepared_temporal["values_total_temporal"] = temporal_values
    prepared_temporal["growth_total_temporal"] = temporal_growth

    return prepared_temporal


def prepare_single_indicator_list(indicator, indicator_name):
    sort_indicator = {}
    prepared_indicator = {}

    sort_indicator = sort_dict(indicator)
    keys = []
    values = []

    for key in sort_indicator:
        keys.append(key)
        values.append(sort_indicator[key])

    prepared_indicator['keys_' + indicator_name] = keys
    prepared_indicator['values_' + indicator_name] = values

    return prepared_indicator


def create_temporal_dict(indicator):
    new_temporal = {}

    for key in indicator:
        new_temporal[key] = {}
        for sub_key in indicator[key]:
            new_temporal[key][sub_key] = indicator[key][sub_key]

    return new_temporal


def create_dict(indicator):
    new_dict = {}

    for key in indicator:
        new_dict[key] = indicator[key]

    return new_dict

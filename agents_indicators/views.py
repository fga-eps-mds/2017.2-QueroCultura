from .api_connection import RequestAgentsRawData
from django.shortcuts import render
from .models import PercentIndividualAndCollectiveAgent
from .models import AmountAgentsRegisteredPerMonth 
from .models import PercentAgentsPerAreaOperation
from datetime import datetime
import json

def index(request):

    update_agent_indicator("http://mapas.cultura.gov.br/api/agent/find/")
    index = AmountAgentsRegisteredPerMonth.objects.count()
  
    queryset = AmountAgentsRegisteredPerMonth.objects[index-1]
    queryset = queryset.total_agents_registered_month["2016"]

    names = queryset.keys()
    prices = queryset.values()

    context = {
        'names': json.dumps(names),
        'prices': json.dumps(prices),
    }

    return render(request, 'index.html', context)


def build_temporal_indicator(new_data, old_data):
    temporal_indicator = {}

    for i in new_data:
        x = i["createTimestamp"]["date"].split("-")

        if not (x[0] in temporal_indicator):
            temporal_indicator[x[0]] = {}
            temporal_indicator[x[0]][x[1]] = 1
        elif not (x[1] in temporal_indicator.get(x[0])):
            temporal_indicator[x[0]][x[1]] = 1
        else:
            temporal_indicator[x[0]][x[1]] += 1

    for i in old_data:
        if not (i in temporal_indicator):
            temporal_indicator[i] = old_data[i]
        else:
            for j in old_data[i]:
                if not (j in temporal_indicator[i]):
                    temporal_indicator[i][j] = old_data[i][j]
                else:
                    temporal_indicator[i][j] += old_data[i][j]

    return temporal_indicator


def build_type_indicator(data):
    per_type = {}

    for i in data:
        if not (i["type"]["name"] in per_type):
            per_type[i["type"]["name"]] = 1
        else:
            per_type[i["type"]["name"]] += 1

    return per_type


def build_operation_area_indicator(new_data, old_data):
    per_operation_area = {}

    for i in new_data:
        for j in i["terms"]["area"]:
            if not (j in per_operation_area):
                per_operation_area[j] = 1
            else:
                per_operation_area[j] += 1

    for i in old_data:
            if not (i in per_operation_area):
                per_operation_area[i] = old_data[i]
            else:
                per_operation_area[i] += old_data[i]

    return per_operation_area


def update_agent_indicator(url):

    if len(PercentIndividualAndCollectiveAgent.objects) == 0:
        PercentIndividualAndCollectiveAgent(0, "2012-01-01 15:47:38.337553", 0, 0).save()

    if len(PercentAgentsPerAreaOperation.objects) == 0:
        PercentAgentsPerAreaOperation(0, "2012-01-01 15:47:38.337553", {"Literarura": 0}).save()

    if len(AmountAgentsRegisteredPerMonth.objects) == 0:
        AmountAgentsRegisteredPerMonth({"2015": {"01": 0}}, "2012-01-01 15:47:38.337553").save()

    index = PercentAgentsPerAreaOperation.objects.count()

    last_per_area = PercentAgentsPerAreaOperation.objects[index-1]
    last_type = PercentIndividualAndCollectiveAgent.objects[index-1]
    last_temporal = AmountAgentsRegisteredPerMonth.objects[index-1]

    request = RequestAgentsRawData(last_per_area.create_date, url)

    new_total = request.data_length + last_per_area.total_agents
    new_create_date = datetime.now().__str__()

    new_per_area = build_operation_area_indicator(request.data, last_per_area.total_agents_area_oreration)
    new_per_month = build_temporal_indicator(request.data, last_temporal.total_agents_registered_month)
    new_type = build_type_indicator(request.data)

    new_individual = last_type.total_individual_agent + new_type["Individual"]
    new_collective = last_type.total_collective_agent + new_type["Coletivo"]

    AmountAgentsRegisteredPerMonth(new_per_month, new_create_date).save()
    PercentIndividualAndCollectiveAgent(new_total, new_create_date, new_individual, new_collective).save()
    PercentAgentsPerAreaOperation(new_total, new_create_date, new_per_area).save()

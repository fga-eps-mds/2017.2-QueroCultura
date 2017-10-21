from .api_connection import RequestAgentsRawData
from django.shortcuts import render
from .models import PercentIndividualAndCollectiveAgent
from .models import AmountAgentsRegisteredPerMonth
from .models import PercentAgentsPerAreaOperation
from datetime import datetime


def build_temporal_indicator(data):
    temporal_indicator = {}

    for i in data:
        x = i["createTimestamp"]["date"].split("-")

        if not (x[0] in temporal_indicator):
            temporal_indicator[x[0]] = {}
            temporal_indicator[x[0]][x[1]] = 1
        elif not (x[1] in temporal_indicator.get(x[0])):
            temporal_indicator[x[0]][x[1]] = 1
        else:
            temporal_indicator[x[0]][x[1]] += 1

    return temporal_indicator


def build_type_indicator(data):
    per_type = {}

    for i in data:
        if not (i["type"]["name"] in per_type):
            per_type[i["type"]["name"]] = 1
        else:
            per_type[i["type"]["name"]] += 1

    return per_type


def build_operation_area_indicator(data):
    per_operation_area = {}

    for i in data:
        for j in i["terms"]["area"]:
            if not (j in per_operation_area):
                per_operation_area[j] = 1
            else:
                per_operation_area[j] += 1

    return per_operation_area


def update_agent_indicator():

    if len(PercentIndividualAndCollectiveAgent.objects) == 0:
        PercentIndividualAndCollectiveAgent(0, "2010-01-01 15:47:38.337553", 0, 0).save()

    if len(PercentAgentsPerAreaOperation.objects) == 0:
        PercentAgentsPerAreaOperation(0, "2010-01-01 15:47:38.337553", {"00": 0}).save()

    if len(AmountAgentsRegisteredPerMonth.objects) == 0:
        AmountAgentsRegisteredPerMonth({"00": 0}, "2010-01-01 15:47:38.337553").save()

    index = PercentAgentsPerAreaOperation.objects.count()

    last_per_area = PercentAgentsPerAreaOperation.objects[index-1]
    last_type = PercentIndividualAndCollectiveAgent.objects[index-1]
    last_temporal = AmountAgentsRegisteredPerMonth.objects[index-1]

    request = RequestAgentsRawData(last_per_area.create_date, "http://mapas.cultura.gov.br/api/agent/find/")

    new_total = request.data_length + last_per_area.total_agents
    new_create_date = datetime.now().__str__()

    new_per_area = build_operation_area_indicator(request.data)

    new_per_month = build_temporal_indicator(request.data)

    new_type = build_type_indicator(request.data)
    new_individual = last_type.total_individual_agent + new_type["Individual"]
    new_collective = last_type.total_collective_agent + new_type["Coletivo"]

    AmountAgentsRegisteredPerMonth(new_per_month, new_create_date).save()
    PercentIndividualAndCollectiveAgent(new_total, new_create_date, new_individual, new_collective).save()
    PercentAgentsPerAreaOperation(new_total, new_create_date, new_per_area).save()

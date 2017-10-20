from django.shortcuts import render
from .api_connection import RequestAgentsRawData


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

# print(build_temporal_indicator(RequestAgentsRawData("2015-05-20 15:47:38.337553", "http://mapas.cultura.gov.br/api/agent/find/").data))
# print(build_type_indicator(RequestAgentsRawData("2015-05-20 15:47:38.337553", "http://mapas.cultura.gov.br/api/agent/find/").data))
# print(build_operation_area_indicator(RequestAgentsRawData("2015-05-20 15:47:38.337553", "http://mapas.cultura.gov.br/api/agent/find/").data))

from django.shortcuts import render
import yaml
from collections import OrderedDict


def index(request):
    return render(request, 'quero_cultura/index.html', {})


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


def build_simple_indicator(new_data, atribute):
    indicator = {}

    for register in new_data:
        if not (str(register[atribute]) in indicator):
            indicator[str(register[atribute])] = 1
        else:
            indicator[str(register[atribute])] += 1

    return indicator


def build_compound_indicator(new_data, first_atribute, second_atribute):
    indicator = {}

    for register in new_data:
        if not (str(register[first_atribute][second_atribute]) in indicator):
            indicator[str(register[first_atribute][second_atribute])] = 1
        else:
            indicator[str(register[first_atribute][second_atribute])] += 1

    return indicator


def merge_indicators(indicator, old_data):
    new_indicator = indicator

    for register in old_data:
        if not (register in new_indicator):
            new_indicator[register] = old_data[register]
        else:
            new_indicator[register] += old_data[register]

    return indicator


def build_two_loop_indicator(new_data, first_atribute, second_atribute):
    indicator = {}

    for register in new_data:
        for sub_register in register[first_atribute][second_atribute]:
            if not (str(sub_register) in indicator):
                indicator[str(sub_register)] = 1
            else:
                indicator[str(sub_register)] += 1

    return indicator


def build_temporal_indicator(new_data, old_data):
    temporal_indicator = {}

    for register in new_data:
        split_date = register["createTimestamp"]["date"].split("-")

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


def sort_dict(dictionary):
    return dict(OrderedDict(sorted(dictionary.items(), key = lambda t:t[1])))


class ParserYAML(object):
    def __init__(self):
        self._urls_files = open("./urls.yaml", 'r')
        self._urls = yaml.load(self._urls_files)
        self._multi_instances_urls = self._urls['multi-instancias']
        self._library_urls = self._urls['bibliotecas']
        self._museums_urls = self._urls['museus']

    @property
    def get_multi_instances_urls(self):
        return self._multi_instances_urls

    @property
    def get_library_urls(self):
        return self._library_urls

    @property
    def get_museums_urls(self):
        return self._museums_urls

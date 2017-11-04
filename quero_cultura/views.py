from django.shortcuts import render
import yaml


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

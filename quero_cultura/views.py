from django.shortcuts import render
from collections import OrderedDict
from .api_connections import RequestMarkersRawData
from .models import Marker
from celery.decorators import task
import requests
import json
import datetime
import yaml
import jwt



METABASE_SECRET_KEY = "1798c3ba25f5799bd75538a7fe2896b79e24f3ec1df9d921558899dc690bbcd9"
METABASE_SITE_URL = "http://0.0.0.0:3000"

INSTANCE_URLS = ['http://mapas.cultura.gov.br/api/',
                    'http://spcultura.prefeitura.sp.gov.br/api/',
                    'http://mapa.cultura.ce.gov.br/api/']

MARKER_TYPES = ['event', 'agent', 'project', 'space']
class UpdateMarkers(object):

    # instance_urls
    # marker_types
    # last_day
    @task(name="last_day_update_map")
    def last_day_update_map():

        last_day = 1
        query_date_time = datetime.datetime.now() - datetime.timedelta(days=last_day)

        # First time the server is up
        if Marker.objects().count() == 0:
            for url in INSTANCE_URLS:
                for marker_type in MARKER_TYPES:
                    request = RequestMarkersRawData(query_date_time, url, marker_type)
                    UpdateMarkers.save_markers_data(request.data, marker_type)


    def save_markers_data(data, marker_type):
        for j_object in data:
            print(j_object)
            print('TIPO: ' + marker_type)
            name = UpdateMarkers.get_attribute(j_object, 'name')
            single_url = UpdateMarkers.get_attribute(j_object, 'singleUrl')
            subsite = UpdateMarkers.get_attribute(j_object, 'subsite')
            subsite = 0 if subsite == '' else subsite
            create_timestamp = UpdateMarkers.get_date(UpdateMarkers.get_attribute(j_object, 'createTimestamp'))
            update_timestamp = UpdateMarkers.get_date(UpdateMarkers.get_attribute(j_object, 'updateTimestamp'))
            action = UpdateMarkers.get_marker_action(create_timestamp, update_timestamp)
            action_time = action['time']
            action_type = action['type']

            location = UpdateMarkers.get_location(j_object, marker_type)

            city, state = UpdateMarkers.get_marker_address(location)
            
            Marker(name, marker_type, action_type, action_time, city, state,
                    single_url, subsite, create_timestamp, update_timestamp, location).save()


    def get_marker_action(create_timestamp, update_timestamp):
        print(create_timestamp)
        print(update_timestamp)
        action = {}
        if update_timestamp is None or update_timestamp == '':
            action['type'] = 'creation'
            action['time']= create_timestamp
        else:
            action['type'] = 'update'
            action['time'] = update_timestamp

        print(action)
        return action


    def get_marker_address(location):
        if location is not None:
            if location['latitude'] != '0' or location['longitude'] != '0':
                latitude = str(location['latitude'])
                longitude = str(location['longitude'])
                openstreetURL = "http://nominatim.openstreetmap.org/reverse?lat="+latitude+"&lon="+longitude+"&format=json"
                print(openstreetURL)
                data = json.loads(requests.get(openstreetURL).text)
                try:
                    return (data['address']['city_district'], data['address']['state'])
                except:
                    pass

        return (None, None)


    def get_attribute(j_object, key):
        try:
            attribute = j_object[key]
        except:
            attribute = ''

        return attribute

    
    def get_date(timestamp):
        print(timestamp)
        if timestamp is not None and timestamp != '':
            date = timestamp['date']
        else:
            date = None

        return date


            if marker_type = 'project':
                location = None
                if j_object['owner'] is not None:
                    location = j_object['owner']['location']
            else:
                location = j_object['location']

            city, state = get_marker_address(location)
            
            Marker(marker_id, name, marker_type, action_type, city, state,
                    single_url, subsite, create_time_stamp, update_time_stamp, location).save()


    def get_marker_action(marker):
        if marker['updateTimeStamp'] == None:
                action_type = 'creation'
            else:
                action_type = 'update'

        return action_type


    def get_date(time_stamp):
        pass


    def get_marker_address(location):
        if location is not None:
            if location['latitude'] != '0' or location['longitude'] != '0':
                openstreetURL = "http://nominatim.openstreetmap.org/reverse?lat="+location['latitude']+"&lon="+location['longitude']+"&format=json"
                data = json.loads(requests.get(openstreetURL).text)
                return (data['address']['city_district'], data['address']['state'])

        return ('', '')

 

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


def get_metabase_url(view_type, number):
    payload = {"resource": {view_type: number},
               "params": {}}

    token = jwt.encode(payload, METABASE_SECRET_KEY, algorithm='HS256')
    token = str(token).replace("b'", "")
    token = token.replace("'", "")

    return METABASE_SITE_URL + "/embed/" + view_type + "/" + token + "#bordered=true&titled=true"

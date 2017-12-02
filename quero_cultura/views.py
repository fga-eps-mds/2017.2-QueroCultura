from django.shortcuts import render
from collections import OrderedDict
from .api_connections import RequestMarkersRawData
from .models import Marker, LastRequest
from celery.decorators import task
from pprint import pprint
from django.http import JsonResponse
import requests
import json
import datetime
import yaml
import jwt



METABASE_SECRET_KEY = "1798c3ba25f5799bd75538a7fe2896b79e24f3ec1df9d921558899dc690bbcd9"
METABASE_SITE_URL = "http://0.0.0.0:3000"

MARKER_TYPES = ['event', 'agent', 'project', 'space']


def load_markers(requested_time):

    parser_yaml = ParserYAML()
    urls = parser_yaml.get_multi_instances_urls
    for url in urls:
        for marker_type in MARKER_TYPES:
            request = RequestMarkersRawData(requested_time,
                                            url, marker_type)
            save_markers_data(request.data, marker_type)


def save_markers_data(data, marker_type):
    for j_object in data:
        print(j_object)

        marker = filter_data(j_object, marker_type)

        Marker(marker['platform_id'], marker['name'], marker_type,
               marker['action_type'], marker['action_time'], marker['city'],
               marker['state'], marker['single_url'], marker['subsite'],
               marker['create_timestamp'], marker['update_timestamp'],
               marker['location']).save()


def filter_data(j_object, marker_type):
    marker = {}
    marker['name'] = get_attribute(j_object, 'name')
    marker['single_url'] = get_attribute(j_object, 'singleUrl')
    marker['platform_id'] = get_attribute(j_object, 'id')

    marker['subsite'] = get_attribute(j_object, 'subsite')
    marker['subsite'] = 0 if marker['subsite'] == '' else marker['subsite']

    create_timestamp = get_date(j_object, 'createTimestamp')
    update_timestamp = get_date(j_object, 'updateTimestamp')
    action = get_marker_action(create_timestamp, update_timestamp)

    marker['create_timestamp'] = create_timestamp
    marker['update_timestamp'] = update_timestamp
    marker['action_time'] = action['time']
    marker['action_type'] = action['type']

    marker['location'] = get_location(j_object, marker_type)
    marker['city'], marker['state'] = get_marker_address(marker['location'])

    return marker


def get_marker_action(create_timestamp, update_timestamp):
    action = {}

    if update_timestamp is None or update_timestamp == '':
        action['type'] = 'Criação'
        action['time'] = create_timestamp
    else:
        action['type'] = 'Atualização'
        action['time'] = update_timestamp

    return action


def get_marker_address(location):
    if location is not None:
        if location['latitude'] != '0' or location['longitude'] != '0':

            latitude = "lat="+location['latitude']
            longitude = "lon="+location['longitude']
            base_url = "http://nominatim.openstreetmap.org/reverse?"

            open_street_url = base_url+latitude+"&"+longitude+"&format=json"

            data = json.loads(requests.get(open_street_url).text)
            try:
                return (data['address']['city_district'],
                        data['address']['state'])
            except:
                return('', '')

    return (None, None)


def get_attribute(j_object, key):
    try:
        attribute = j_object[key]
    except:
        attribute = ''

    return attribute

def get_date(j_object, which_timestamp):
    timestamp = get_attribute(j_object, which_timestamp)
    if timestamp is not None and timestamp != '':
        date = timestamp['date']
    else:
        date = None

    return date


def get_location(j_object, marker_type):
    if marker_type == 'project':
        if j_object['owner'] is not None:
            location = j_object['owner']['location']
        else:
            location = {'latitude': '0', 'longitude': '0'}

    elif marker_type == 'event':
        try:
            location = j_object['occurrences'].pop()['space']['location']
        except:
            location = {'latitude': '0', 'longitude': '0'}
    else:
        try:
            location = j_object['location']
        except:
            location = {'latitude': '0', 'longitude': '0'}

    return location


def remove_expired_markers():
    all_markers = Marker.objects.all()

    for marker in all_markers:
        if marker.action_time < (datetime.datetime.now() - datetime.timedelta(days=1)):
            marker.delete()


def update_last_request_date(new_date):
    print('AUPDATING LAST REQUEST TABLE')
    LastRequest.objects.all().delete()
    last_request_date = LastRequest(new_date)
    last_request_date.save()


def get_last_request_date():
    try:
        return LastRequest.objects.all().order_by('-date')[:1][0].date
    except IndexError as e:
        return get_time_now() - datetime.timedelta(days=1)


def get_time_now():
    # 2 hours Timezone GMT-3
    cur_date = datetime.datetime.now() - datetime.timedelta(hours=2)
    return cur_date


def verify_database_state(query_time, valid_request_date):

    cur_date = get_time_now()


    last_request_date = get_last_request_date()


    if (Marker.objects.count() == 0 or cur_date > last_request_date + valid_request_date):
        update_last_request_date(cur_date)
        load_markers(last_request_date)


def get_last_day_markers():

    cur_date = get_time_now()
    one_hour_behind_date = cur_date - datetime.timedelta(hours=1)
    one_day_behind_date = cur_date - datetime.timedelta(days=1)

    day_in_minutes = 1440
    validate_time = datetime.timedelta(hours=2)
    verify_database_state(day_in_minutes, validate_time)

    # this line is needed to not get markers that are in last hour
    behind_one_hour_markers = Marker.objects.filter(action_time__lte=one_hour_behind_date)
    last_day_markers = behind_one_hour_markers.filter(action_time__gte=one_day_behind_date)

    return convert_mongo_to_dict(last_day_markers)


def convert_mongo_to_dict(mongo_objects):
    result = []
    for marker in mongo_objects:
        # convert mongo object to dict
        new_marker = marker.to_mongo()

        # Destroy objectid object, so that javascript understands
        new_marker['_id'] = ''
        # Convert datetime fields to str, so that JavaScript understands
        try:
            new_marker['update_time_stamp'] = str(new_marker['update_time_stamp'])
        except Exception as e:
            new_marker['update_time_stamp'] = ''
        try:
            new_marker['subsite']
        except Exception as e:
            new_marker['subsite'] = "null"
        new_marker['create_time_stamp'] = str(new_marker['create_time_stamp'])
        new_marker['action_time'] = str(new_marker['action_time'])

        result.append(dict(new_marker))

    return result


def get_last_hour_markers():

    hour_in_minutes = 60

    cur_date = get_time_now()
    one_hour_behind_date = cur_date - datetime.timedelta(hours=1)

    verify_database_state(hour_in_minutes, datetime.timedelta(hours=1))

    last_hour_markers = Marker.objects.filter(action_time__gte=one_hour_behind_date)

    return convert_mongo_to_dict(last_hour_markers)


def get_last_three_minutes_markers():

    three_minutes = 3

    cur_date = get_time_now()
    three_minutes_behind_date = cur_date - datetime.timedelta(minutes=3)

    verify_database_state(three_minutes, datetime.timedelta(minutes=3))

    last_three_minutes_markers = Marker.objects.filter(action_time__gte=three_minutes_behind_date)

    return convert_mongo_to_dict(last_three_minutes_markers)

def get_last_three_minutes_test(request):

    three_minutes = 3

    cur_date = get_time_now()
    three_minutes_behind_date = cur_date - datetime.timedelta(minutes=3)

    verify_database_state(three_minutes, datetime.timedelta(minutes=3))

    last_three_minutes_markers = Marker.objects.filter(action_time__gte=three_minutes_behind_date)

    return JsonResponse({'markers': convert_mongo_to_dict(last_three_minutes_markers)})


def get_most_recent_markers():
    ordered_markers = Marker.objects.order_by('-action_time')
    last_minute_markers = []

    n_of_markers = 5

    if len(ordered_markers) >= n_of_markers:
        for i in range(0, n_of_markers):
            last_minute_markers.append(ordered_markers[i])
    else:
        last_minute_markers += ordered_markers

    return convert_mongo_to_dict(last_minute_markers)


def index(request):
    markers_context = {"get_most_recent_markers": get_most_recent_markers,
                       "get_last_day_markers": get_last_day_markers,
                       "get_last_three_minutes_markers": get_last_three_minutes_markers,
                       "get_last_hour_markers": get_last_hour_markers,
                      }
    return render(request, 'quero_cultura/index.html', markers_context)


def build_operation_area_indicator(new_data, old_data):
    per_operation_area = {}

    for agent in new_data:
        for area in agent["terms"]["area"]:
            if area not in per_operation_area:
                per_operation_area[area] = 1
            else:
                per_operation_area[area] += 1

    for area in old_data:
        if area not in per_operation_area:
            per_operation_area[area] = old_data[area]
        else:
            per_operation_area[area] += old_data[area]

    return per_operation_area


def build_simple_indicator(new_data, atribute):
    indicator = {}

    for register in new_data:
        if str(register[atribute]) not in indicator:
            indicator[str(register[atribute])] = 1
        else:
            indicator[str(register[atribute])] += 1

    return indicator


def build_compound_indicator(new_data, first_atribute, second_atribute):
    indicator = {}

    for register in new_data:
        if str(register[first_atribute][second_atribute]) not in indicator:
            indicator[str(register[first_atribute][second_atribute])] = 1
        else:
            indicator[str(register[first_atribute][second_atribute])] += 1

    return indicator


def merge_indicators(indicator, old_data):
    new_indicator = indicator

    for register in old_data:
        if register not in new_indicator:
            new_indicator[register] = old_data[register]
        else:
            new_indicator[register] += old_data[register]

    return indicator


def build_two_loop_indicator(new_data, first_atribute, second_atribute):
    indicator = {}

    for register in new_data:
        for sub_register in register[first_atribute][second_atribute]:
            if str(sub_register) not in indicator:
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

        if year not in temporal_indicator:
            temporal_indicator[year] = {}
            temporal_indicator[year][month] = 1
        elif month not in temporal_indicator.get(year):
            temporal_indicator[year][month] = 1
        else:
            temporal_indicator[year][month] += 1

    for year in old_data:
        if year not in temporal_indicator:
            temporal_indicator[year] = old_data[year]
        else:
            for month in old_data[year]:
                if month not in temporal_indicator[year]:
                    temporal_indicator[year][month] = old_data[year][month]
                else:
                    temporal_indicator[year][month] += old_data[year][month]

    return temporal_indicator


def sort_dict(dictionary):
    return dict(OrderedDict(sorted(dictionary.items(), key=lambda t: t[1])))


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

    return (METABASE_SITE_URL + "/embed/" + view_type + "/" + token +
            "#bordered=true&titled=true")

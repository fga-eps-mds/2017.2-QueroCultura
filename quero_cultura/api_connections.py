import json
import requests
from .models import Marker, Subsite


SPACE_SELECT = 'id, name, location, singleUrl, subsite, createTimestamp, updateTimestamp'
EVENT_SELECT = 'id, name, occurrences.{space.{location}}, singleUrl, subsite, createTimestamp, updateTimestamp'
AGENT_SELECT = 'id, name, location, singleUrl, subsite, createTimestamp, updateTimestamp'
PROJECT_SELECT = 'id, name, owner.location, singleUrl, subsite, createTimestamp, updateTimestamp'

class RequestMarkersRawData(object):

    def __init__(self, query_date_time, url, marker_type):

        select = choose_select(marker_type)
        self._filters = {'@select': select,
                         '@or': 1,
                         'createTimestamp': "GT("+str(query_date_time)+")",
                         'updateTimestamp': "GT("+str(query_date_time)+")"
                        }
        self._response = requests.get(url+marker_type+"/find/", self._filters)
        self._data = json.loads(self._response.text)

    @property
    def response(self):
        return self._response

    @property
    def data(self):
        return self._data

    @property
    def data_length(self):
        return len(self._data)



def choose_select(marker_type):
    if marker_type == 'event':
        select = EVENT_SELECT
    elif marker_type == 'agent':
        select = AGENT_SELECT
    elif marker_type == 'project':
        select = PROJECT_SELECT
    elif marker_type == 'space':
        select = SPACE_SELECT
    else:
        raise ValueError('Invalid marker type')

    return select


def save_markers_data(data, marker_type):
    for j_object in data:
        print(j_object)

        marker = filter_data(j_object, marker_type)

        Marker(marker['platform_id'], marker['name'], marker_type,
            marker['action_type'], marker['action_time'], marker['city'],
            marker['state'], marker['single_url'], marker['subsite'],
            marker['instance_url'], marker['create_timestamp'],
            marker['update_timestamp'], marker['location']).save()


def filter_data(j_object, marker_type):
    marker = {}
    marker['name'] = get_attribute(j_object, 'name')
    marker['single_url'] = get_attribute(j_object, 'singleUrl')
    marker['platform_id'] = get_attribute(j_object, 'id')

    marker['subsite'] = get_attribute(j_object, 'subsite')
    marker['subsite'] = 0 if marker['subsite'] == '' else marker['subsite']

    marker['instance_url'] = get_instance_url(j_object)

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


# We need this method because some API data are
# inconsistent then we use this method to avoid
# unexpected errors
def get_attribute(j_object, key):
    try:
        attribute = j_object[key]
    except:
        attribute = ''

    return attribute


# To know which action was executed (create or update)
# at the mapas platform we use this method
def get_marker_action(create_timestamp, update_timestamp):
    action = {}

    if update_timestamp is None or update_timestamp == '':
        action['type'] = 'Criação'
        action['time'] = create_timestamp
    else:
        action['type'] = 'Atualização'
        action['time'] = update_timestamp

    return action


# The API's used by this project doesn't give the
# specific address information like city or state
# but only latitude and longitude so to get this
# information we request from a third party service
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


def get_date(j_object, which_timestamp):
    timestamp = get_attribute(j_object, which_timestamp)
    if timestamp is not None and timestamp != '':
        date = timestamp['date']
    else:
        date = None

    return date


# Each type of marker has your own way
# to storage the location information
# so we have a specific logic for each type
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


def get_instance_url(j_object):
    
    subsite_id = j_object['subsite']
    splitted_url = j_object['singleUrl'].split('/')

    if subsite_id != 'null' and subsite_id is not None:
        try:
            subsite = Subsite.objects.filter(subsite_id=int(subsite_id))[:1].get()

            specific_url_info = '/' + splitted_url[3] + '/' + str(j_object['id'])

            return subsite.url + specific_url_info 
        except Subsite.DoesNotExist:
            specific_url_info = '/' + splitted_url[3] + '/' + str(j_object['id'])
            instance_url = splitted_url[0] + '//' + splitted_url[2] 

            return  request_subsite_url(subsite_id, instance_url) + specific_url_info
    else:
        return j_object['singleUrl']


def request_subsite_url(subsite_id, instance_url):
    
    filters = { '@select' : 'url',
                'id': 'eq('+str(subsite_id)+')'
                }
    response = requests.get(instance_url + '/api/subsite/find', filters)
    data = json.loads(response.text)

    subsite_url = 'http://' + data[0]['url']
    subsite = Subsite(subsite_id, subsite_url)
    subsite.save()

    return subsite_url
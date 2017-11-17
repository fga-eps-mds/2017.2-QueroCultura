import json
import requests


SPACE_SELECT = ''
EVENT_SELECT = 'name, occurrences.{space.{location}}, singleUrl, subsite, createTimestamp, updateTimestamp'
AGENT_SELECT = 'name, location, singleUrl, subsite, createTimestamp, updateTimestamp'
PROJECT_SELECT = 'name, owner.location, singleUrl, subsite, createTimestamp, updateTimestamp'

class RequestMarkersRawData(object):

    def __init__(self, query_date_time, url, marker_type):

        select = choose_select(marker_type)
        self._filters = {'@select' : select,
                         '@or' : 1,
                         'createTimestamp' : "GT("+query_date_time+")",
                         'updateTimestamp' : "GT("+query_date_time+")"
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
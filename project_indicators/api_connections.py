import json
import requests


class RequestProjectsRawData(object):

    def __init__(self, last_update_time):
        self._get_time = last_update_time
        self._url = 'http://mapas.cultura.gov.br/api/project/find/'
        self._filters = {'@select': 'type, createTimestamp',
                         'createTimestamp': "GT("+self._get_time+")"}
        self._response = requests.get(self._url, self._filters)
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

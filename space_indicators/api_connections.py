import json
import requests


class RequestSpacesRawData(object):

    def __init__(self, last_update_time, url):
        self._filters = {'@select': 'type, createTimestamp, terms, name',
                         'createTimestamp': "GT("+last_update_time+")"}
        self._response = requests.get(url+"space/find/", self._filters)
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

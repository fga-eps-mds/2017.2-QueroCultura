import json
import requests


class RequestMixedIndicatorsRawData(object):

    def __init__(self, last_update_time, url):
        self._filters = {'@select': 'occurrences.{space.{acessibilidade}}, name, createTimestamp',
                         'createTimestamp': "GT("+last_update_time+")"}
        self._response = requests.get(url+"event/find/", self._filters)
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

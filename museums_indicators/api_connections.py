import json
import requests
from quero_cultura.views import ParserYAML


class RequestMuseumRawData(object):

    def __init__(self, last_update_time, url):
        self._filters = {'@select': '*',
                         'type': 'OR(EQ(60), EQ(61))', # 60 is the "Museu Público" id, and 61 is the "Museu Privado" id
                         'createTimestamp': "GT("+last_update_time+")"}
        print(self._filters)
        self._response = requests.get(url+"space/find/", self._filters)
        print(self._response)
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

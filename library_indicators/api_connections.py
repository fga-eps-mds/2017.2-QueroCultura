import json
import requests
from quero_cultura.views import ParserYAML


class RequestLibraryRawData(object):
    def __init__(self, last_update_time, url):
        self._filters = {'@select': 'esfera, esfera_tipo, terms,'
                                    + 'createTimestamp',
                         'createTimestamp': "GT("+last_update_time+")"}
        self._response = requests.get(url, self._filters)
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

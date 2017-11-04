import json
import requests
from quero_cultura.views import ParserYAML


class RequestLibraryRawData(object):
    def __init__(self, last_update_time):
        self._parser_yaml = ParserYAML()
        self._library_url = self._parser_yaml.get_library_urls
        self._url = self._library_url[0]
        self._url = "http://bibliotecas.cultura.gov.br/api/space/find/"
        self._filters = {'@select': 'En_Estado, esfera, esfera_tipo, terms,'
                                    + 'createTimestamp',
                         'createTimestamp': "GT("+last_update_time+")"}
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

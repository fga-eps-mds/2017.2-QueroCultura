import json
import requests
from quero_cultura.views import ParserYAML


class RequestMuseumRawData(object):

    def __init__(self, last_update_time):
        self._parser_yaml = ParserYAML()
        self._museum_url = self._parser_yaml.get_museums_urls
        self._url = self._museum_url[0]
        self._filters = {'@select': 'mus_tipo, mus_tipo_tematica,'
                                    + 'En_Estado, esfera,'
                                    + 'mus_servicos_visitaGuiada, '
                                    + 'mus_arquivo_acessoPublico, '
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

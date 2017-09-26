import requests
import json
from datetime import datetime
from datetime import timedelta


class MapPointsApi(object):

    def __init__(self):
        self._get_time = datetime.now() - timedelta(days=23)
        self._url = 'http://mapas.cultura.gov.br/api/space/find/'
        self._filters = {
            '@select': 'id, name, location, shortDescription',
            '@or': 1,
            'createTimestamp': "GT(" + self._get_time.__str__() + ")",
            'updateTimestamp': "GT(" + self._get_time.__str__() + ")"}
        self._response = requests.get(self._url, self._filters)
        self._data = json.loads(self._response.text)

    @property
    def response(self):
        return self._response

    @property
    def data(self):
        return self._data

# Código abaixo serve para testar o funcionamento da classe a cima! se
# quiser testar basta descomentar o trecho de código.

'''
pontos = MapPointsApi()

print(pontos.response.status_code)

if pontos.response.status_code == 200:
    print(len(pontos.data))

    for i in pontos.data:
        print(i["id"], i["name"], "\n")
        print(i["shortDescription"], "\n")
'''

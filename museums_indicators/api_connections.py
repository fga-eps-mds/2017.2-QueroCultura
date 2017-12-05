import json
import requests


class RequestMuseumRawData(object):

    def __init__(self, last_update_time, url):
        self._filters = {'@select': 'acessibilidade, '
                                    +'terms, '
                                    +'type, '
                                    +'createTimestamp',
                         'type': 'OR(EQ(60),'  #60 is the Public Museum id at API
                                  + 'EQ(61))', #61 is the Public Museum id at API
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

import json
import requests


class RequestLibraryRawData(object):

    def __init__(self, last_update_time, url):
        self._filters = {'@select': 'acessibilidade, '
                                    +'terms, '
                                    +'type, '
                                    +'createTimestamp',
                         'type': 'OR(EQ(20),' #20 is the Public Library id at API
                                  + 'EQ(21),' #21 is the Private Library id at API
                                  + 'EQ(22),' #22 is the Community Library id at API
                                  + 'EQ(23),' #23 is the Scholar Library id at API
                                  + 'EQ(24),' #24 is the National Library id at API
                                  + 'EQ(25),' #25 is the University Library id at API
                                  + 'EQ(26))',#26 is the Specialized Library id at API
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

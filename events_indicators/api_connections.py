import json
import requests


class RequestEventsRawData(object):

    def __init__(self, last_update_time, url):
        self._filters = {'@select': 'classificacaoEtaria, createTimestamp,'
                                    + 'terms, occurrences.{space.{En_Estado}}',
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

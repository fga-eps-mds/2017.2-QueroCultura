import json
import datetime
import requests


class RequestAgentsRawData(object):

    def __init__(self, last_update_time, url):
        self._filters = {'@select': 'terms, type, createTimestamp',
                         'createTimestamp': "GT("+last_update_time+")"}
        self._response = requests.get(url+"agent/find/", self._filters)
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


class RequestAgentsInPeriod(object):

    def __init__(self, year, url):
        self._filters = ''
        self._data = []
        for i in range(1, 13):
            if i < 12:
                initial_date = datetime.date(year, i, 1)
                final_date = datetime.date(year, i+1, 1)
            else:
                initial_date = datetime.date(year, i, 1)
                final_date = datetime.date(year+1, 1, 1)

            data = self.request_data(initial_date, final_date, url)

            self._data += json.loads(data.text)

    def request_data(self, initial_date, final_date, url):
        self._filters = {'@select': 'terms, type, createTimestamp',
                         'createTimestamp': "BET(" + str(initial_date) + ","
                         + str(final_date) + ")"}
        self._response = requests.get(url + "agent/find/", self._filters)
        return self._response

    @property
    def response(self):
        return self._response

    @property
    def data(self):
        return self._data

    @property
    def data_length(self):
        return len(self._data)


class EmptyRequest(object):

    def __init__(self):
        self._data = []

    @property
    def data(self):
        return self._data

    @data.setter
    def data(self, data):
        self._data = data

    @property
    def data_length(self):
        return len(self._data)

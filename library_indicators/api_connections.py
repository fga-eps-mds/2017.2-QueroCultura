import json
import requests
import yaml

class RequestLibraryRawData(object):
    def __init__(self, last_update_time):
        self._get_time = last_update_time
        self._url = self.get_url()
        self._filters = {'@select': 'En_Estado, esfera, esfera_tipo, terms,'
                                    + 'createTimestamp',
                         'createTimestamp': "GT("+self._get_time+")"}
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

    def get_url(self):
        urls_files = open("./urls.yaml", 'r')
        urls = yaml.load(urls_files)
        url_list = []
        for url in urls:
            url_list.append(url)
        return url_list[0]

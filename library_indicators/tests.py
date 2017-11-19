from datetime import datetime
from .api_connections import RequestLibraryRawData
import requests_mock
import json

class TestRequestLibraryRawData(object):

    @requests_mock.Mocker(kw='mock')
    def test_request_library_raw_data(self, **kwargs):
        url = "http://bibliotecas.cultura.gov.br/api/space/find"

        result = [{"createTimestamp": {"date": "2012-01-01 00:00:00.000000"},
                   "esfera": "Publica", "esfera_tipo": 'None', 
                   "terms": {"area": ["Cinema", "Teatro"]}}]

        kwargs['mock'].get(url, text=json.dumps(result))

        current_time = datetime.now().__str__()
        raw_data = RequestLibraryRawData(current_time, url)
        assert raw_data.response.status_code == 200
        assert raw_data.data == result
        assert raw_data.data_length == 1


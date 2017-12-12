from datetime import datetime
from .api_connections import RequestMarkersRawData
import requests_mock
import json


class TestRequestMarkerRawData(object):

    @requests_mock.Mocker(kw='mock')
    def test_request_marker_raw_data(self, **kwargs):
        url = "http://mapas.cultura.gov.br/api/"
        marker = 'agent'
        result = [{"id": 1, "date": "2012-01-01 00:00:00.000000",
                  "name": "larissa", "useRegistrations": "FGA"}]

        kwargs['mock'].get(url + marker + "/find/", text=json.dumps(result))

        current_time = datetime.now().__str__()
        raw_data = RequestMarkersRawData(current_time, url, marker)
        assert raw_data.response.status_code == 200
        assert raw_data.data == result
        assert raw_data.data_length == 1

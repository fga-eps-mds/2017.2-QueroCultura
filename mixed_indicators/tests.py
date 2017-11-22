from datetime import datetime
from .api_connections import RequestMixedIndicatorsRawData
import requests_mock
import json


class TestClassRequestMixedRawData(object):
    @requests_mock.Mocker(kw='mock')
    def test_request_mixed_raw_data(self, **kwargs):
        url = "http://mapas.cultura.gov.br/api/"

        result = [{'occurrences': [{'space': {'acessibilidade': 'Sim', 'id': 13242}, 'id': 401}], 'id': 882}]

        kwargs['mock'].get(url + "event/find/", text=json.dumps(result))

        current_time = datetime.now().__str__()
        raw_data = RequestMixedIndicatorsRawData(current_time,
                                          "http://mapas.cultura.gov.br/api/")
        assert raw_data.response.status_code == 200
        assert raw_data.data == result
        assert raw_data.data_length == 1

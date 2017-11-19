from datetime import datetime
from .api_connections import RequestMuseumRawData
import requests_mock
import json


class TestRequestMuseumRawData(object):

    @requests_mock.Mocker(kw='mock')
    def test_request_museum_raw_data(self, **kwargs):
        url = "http://museus.cultura.gov.br/api/space/find"

        result = [{"createTimestamp": {"date": "2012-01-01 00:00:00.000000"},
                   "esfera": "Publica", "mus_tipo": 'None', 
                   "mus_tipo_tematica": 'None',
                   "mus_servicos_visitaGuiada": 'None',
                   "mus_arquivo_acessoPublico": 'None'}]

        kwargs['mock'].get(url, text=json.dumps(result))

        current_time = datetime.now().__str__()
        raw_data = RequestMuseumRawData(current_time, url)
        assert raw_data.response.status_code == 200
        assert raw_data.data == result
        assert raw_data.data_length == 1

from datetime import datetime
from .api_connections import RequestProjectsRawData
from .views import update_project_indicator
from quero_cultura.views import ParserYAML
import requests_mock
import json
import requests
import yaml


class TestClassRequestProjectsRawData(object):

    def test_success_request(self):
        current_time = datetime.now().__str__()
        request_project_raw_data = RequestProjectsRawData(
            current_time, "http://mapas.cultura.gov.br/api/")
        response_project_raw_data = request_project_raw_data.response
        response_status_code = response_project_raw_data.status_code
        assert response_status_code == 200

    def test_data_content(self):
        current_time = datetime.now().__str__()
        request_project_raw_data = RequestProjectsRawData(
            current_time, "http://mapas.cultura.gov.br/api/")
        project_raw_data = request_project_raw_data.data
        type_project_raw_data = type(project_raw_data)
        empty_list = []
        assert type_project_raw_data == type(empty_list)

    def test_data_lenght(self):
        current_time = datetime.now().__str__()
        request_project_raw_data = RequestProjectsRawData(
            current_time, "http://mapas.cultura.gov.br/api/")
        project_raw_data = request_project_raw_data.data_length
        type_project_raw_data = type(project_raw_data)
        intenger = 1
        assert type_project_raw_data == type(intenger)


class TestUpdateProjectIndicator(object):

    @requests_mock.Mocker(kw='mock')
    def test_update_event_indicator(self, **kwargs):

        parser_yaml = ParserYAML()

        urls = parser_yaml.get_multi_instances_urls

        result = [{"createTimestamp": {"date": "2012-01-01 00:00:00.000000"},
                   "type": {"name": "Oficina"}, "useRegistrations": True}]

        for url in urls:
            kwargs['mock'].get(url + "project/find/", text=json.dumps(result))

        PercentProjectPerType.drop_collection()
        PercentProjectThatAcceptOnlineTransitions.drop_collection()
        QuantityOfRegisteredProject.drop_collection()

        update_project_indicator()

        total = len(PercentProjectPerType.objects)
        total += len(PercentProjectThatAcceptOnlineTransitions.objects)
        total += len(QuantityOfRegisteredProject.objects)

        assert total == 6

from datetime import datetime
from .api_connections import RequestProjectsRawData
from .views import populate_project_data
from .models import LastUpdateProjectDate
from .models import ProjectData
from quero_cultura.views import ParserYAML
import requests_mock
import yaml


class TestLastUpdateProjectDate(object):
    def test_last_update_project_date(self):
        LastUpdateProjectDate.drop_collection()
        create_date = datetime.now().__str__()
        LastUpdateProjectDate(create_date).save()
        query = LastUpdateProjectDate.objects.first()
        assert query.create_date == create_date


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

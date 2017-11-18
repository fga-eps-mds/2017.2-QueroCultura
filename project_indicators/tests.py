from datetime import datetime
from .api_connections import RequestProjectsRawData
from .views import populate_project_data
from .models import LastUpdateProjectDate
from .models import ProjectData
from quero_cultura.views import ParserYAML
import requests_mock
import json


class TestLastUpdateProjectDate(object):
    def test_last_update_project_date(self):
        LastUpdateProjectDate.drop_collection()
        create_date = datetime.now().__str__()
        LastUpdateProjectDate(create_date).save()
        query = LastUpdateProjectDate.objects.first()
        assert query.create_date == create_date


class TestProjectData(object):
    def test_project_data(self):
        ProjectData.drop_collection()
        instance = "SP"
        date = datetime(2017, 11, 14, 3, 5, 55, 88000)
        project_type = "Teatro"
        online = "True"
        ProjectData(instance, project_type, online, date).save()
        query = ProjectData.objects.first()
        assert query.instance == instance
        assert query.online_subscribe == online
        assert query.date == date
        assert query.project_type == project_type


class TestPopulateProjectData(object):
    @requests_mock.Mocker(kw='mock')
    def test_populate_project_data(self, **kwargs):
        parser_yaml = ParserYAML()
        urls = parser_yaml.get_multi_instances_urls

        result = [{"createTimestamp": {"date": "2012-01-01 00:00:00.000000"},
                   "type": {"name": "Livre"}, "useRegistrations": "FGA"}]

        for url in urls:
            kwargs['mock'].get(url + "project/find/", text=json.dumps(result))

        LastUpdateProjectDate.drop_collection()
        ProjectData.drop_collection()

        populate_project_data()

        assert LastUpdateProjectDate.objects.count() != 0
        assert ProjectData.objects.count() != 0


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

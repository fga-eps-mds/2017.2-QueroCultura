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
        update_date = LastUpdateProjectDate()
        create_date = datetime.now().__str__()
        update_date.create_date = create_date
        update_date.save()
        query = LastUpdateProjectDate.objects.first()
        assert query.create_date == create_date


class TestProjectData(object):

    def test_project_data(self):
        ProjectData.drop_collection()
        project_data = ProjectData()
        instance = "SP"
        project_data.instance = instance
        date = datetime(2017, 11, 14, 3, 5, 55, 88000)
        project_data.date = date
        project_type = "Teatro"
        project_data.project_type = project_type
        online = "True"
        project_data.online_subscribe = online
        project_data.save()
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
                   "type": {"name": "Livre"}, "useRegistrations": True},
                  {"createTimestamp": {"date": "2012-01-01 00:00:00.000000"},
                   "type": {"name": "Livre"}, "useRegistrations": False}]

        for url in urls:
            kwargs['mock'].get(url + "project/find/", text=json.dumps(result))

        LastUpdateProjectDate.drop_collection()
        ProjectData.drop_collection()

        populate_project_data()

        assert LastUpdateProjectDate.objects.count() != 0
        assert ProjectData.objects.count() != 0


class TestRequestProjectsRawData(object):

    @requests_mock.Mocker(kw='mock')
    def test_request_projects_raw_data(self, **kwargs):
        url = "http://mapas.cultura.gov.br/api/"

        result = [{"createTimestamp": {"date": "2012-01-01 00:00:00.000000"},
                   "type": {"name": "Livre"}, "useRegistrations": True},
                  {"createTimestamp": {"date": "2012-01-01 00:00:00.000000"},
                   "type": {"name": "Livre"}, "useRegistrations": False}]

        kwargs['mock'].get(url + "project/find/", text=json.dumps(result))

        current_time = datetime.now().__str__()
        raw_data = RequestProjectsRawData(current_time, url)
        assert raw_data.response.status_code == 200
        assert raw_data.data == result
        assert raw_data.data_length == 2

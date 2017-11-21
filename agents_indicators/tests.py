from datetime import datetime
from .api_connection import RequestAgentsRawData
from .models import LastUpdateAgentsDate
from .models import AgentsArea
from .models import AgentsData
import requests_mock
import json


class TestLastUpdateAgentsDate(object):

    def test_last_agents_date(self):
        LastUpdateAgentsDate.drop_collection()
        create_date = datetime.now().__str__()
        LastUpdateAgentsDate(create_date).save()
        query = LastUpdateAgentsDate.objects.first()
        assert query.create_date == create_date


class TestAgentsArea(object):

    def test_agents_area(self):
        AgentsArea.drop_collection()
        instance = "SP"
        area = "Cinema"
        AgentsArea(instance, area).save()
        query = AgentsArea.objects.first()
        assert query.instance == instance
        assert query.area == area


class TestAgentsData(object):

    def test_agents_data(self):
        AgentsData.drop_collection()
        instance = "SP"
        date = datetime(2017, 11, 14, 3, 5, 55, 88000)
        agents_type = "Individual"
        AgentsData(instance, agents_type, date).save()
        query = AgentsData.objects.first()
        assert query.instance == instance
        assert query.date == date
        assert query.agents_type == agents_type


class TestRequestAgentsRawData(object):

    @requests_mock.Mocker(kw='mock')
    def test_request_agents_raw_data(self, **kwargs):
        url = "http://mapas.cultura.gov.br/api/"

        result = {
            'None': 1
        }

        kwargs['mock'].get(url + "agent/find/", text=json.dumps(result))

        current_time = datetime.now().__str__()
        raw_data = RequestAgentsRawData(current_time, url)
        assert raw_data.response.status_code == 200
        assert raw_data.data == result
        assert raw_data.data_length == 1

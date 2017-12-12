from datetime import datetime
from .api_connection import RequestAgentsRawData
from .models import LastUpdateAgentsDate
from .models import AgentsArea
from .models import AgentsData
from .views import populate_agent_data
from quero_cultura.views import ParserYAML
import requests_mock
import json


class TestIndex(object):
    def test_index(self, client):
        response = client.get('agentes/')
        response.status_code == 200


class TestPopulateAgentData(object):
    @requests_mock.Mocker(kw='mock')
    def test_populate_agent_data(self, **kwargs):
        parser_yaml = ParserYAML()
        urls = parser_yaml.get_multi_instances_urls

        result = [{"createTimestamp": {"date": "2012-01-01 00:00:00.000000"},
                   "type": {"name": "Publico"},
                   "terms": {"area": ["Cinema", "Teatro"]}}]

        for url in urls:
            kwargs['mock'].get(url + "agent/find/", text=json.dumps(result))

        LastUpdateAgentsDate.drop_collection()
        AgentsData.drop_collection()
        AgentsArea.drop_collection()

        populate_agent_data()

        assert LastUpdateAgentsDate.objects.count() != 0
        assert AgentsData.objects.count() != 0
        assert AgentsArea.objects.count() != 0


class TestLastUpdateAgentsDate(object):

    def test_last_agents_date(self):
        LastUpdateAgentsDate.drop_collection()
        create_date = datetime.now().__str__()
        update_date = LastUpdateAgentsDate()
        update_date.create_date = create_date
        update_date.save()
        query = LastUpdateAgentsDate.objects.first()
        assert query.create_date == create_date


class TestAgentsArea(object):

    def test_agents_area(self):
        AgentsArea.drop_collection()
        agent_area = AgentsArea()
        instance = "SP"
        agent_area.instance = instance
        area = "Cinema"
        agent_area.area = area
        agent_area.save()
        query = AgentsArea.objects.first()
        assert query.instance == instance
        assert query.area == area


class TestAgentsData(object):

    def test_agents_data(self):
        AgentsData.drop_collection()
        agent_data = AgentsData()
        instance = "SP"
        agent_data.instance = instance
        date = datetime(2017, 11, 14, 3, 5, 55, 88000)
        agent_data.date = date
        agents_type = "Individual"
        agent_data.agents_type = agents_type
        agent_data.save()
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

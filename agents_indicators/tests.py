from datetime import datetime
from .api_connection import RequestAgentsRawData
from .models import PercentIndividualAndCollectiveAgent
from .models import AmountAgentsRegisteredPerMonth
from .models import PercentAgentsPerAreaOperation
from .models import LastUpdateAgentsDate
from .models import AgentsArea
from .models import AgentsData
from .views import update_agent_indicator
import requests_mock
import requests
import json


class TestAmountAgentsRegisteredPerMonth(object):

    @staticmethod
    def total_agents_registered_month():
        AmountAgentsRegisteredPerMonth.drop_collection()
        agents_in_month = AmountAgentsRegisteredPerMonth(
            {"01": 10}, datetime.now().__str__())
        agents_in_month.save()
        query = AmountAgentsRegisteredPerMonth.object.first()
        assert query.total_agents_registered_month == {"01": 10}


class TestPercentIndividualAndCollectiveAgent(object):

    @staticmethod
    def test_total_agents():
        PercentIndividualAndCollectiveAgent.drop_collection()
        agent_indicator = PercentIndividualAndCollectiveAgent(
            50, datetime.now().__str__(), 10, 10)
        agent_indicator.save()
        query = PercentIndividualAndCollectiveAgent.objects.first()
        assert query.total_agents == 50

    @staticmethod
    def test_total_individual_agent():
        PercentIndividualAndCollectiveAgent.drop_collection()
        agent_indicator = PercentIndividualAndCollectiveAgent(
            50, datetime.now().__str__(), 10, 10)
        agent_indicator.save()
        query = PercentIndividualAndCollectiveAgent.objects.first()
        assert query.total_individual_agent == 10

    @staticmethod
    def test_total_collective_agent():
        PercentIndividualAndCollectiveAgent.drop_collection()
        agent_indicator = PercentIndividualAndCollectiveAgent(
            50, datetime.now().__str__(), 10, 10)
        agent_indicator.save()
        query = PercentIndividualAndCollectiveAgent.objects.first()
        assert query.total_collective_agent == 10


class TestRequestAgentsRawData(object):

    @requests_mock.Mocker(kw='mock')
    def test_success_request(self, **kwargs):
        current_time = datetime.now().__str__()
        url = "http://mapas.cultura.gov.br/api/"

        result = {
            'None': 1,
        }

        kwargs['mock'].get(url + "agent/find/", text=json.dumps(result))

        request_agents_raw_data = RequestAgentsRawData(current_time, url)
        response_agents_raw_data = request_agents_raw_data.response
        response_status_code = response_agents_raw_data.status_code

        assert response_status_code == 200

    @requests_mock.Mocker(kw='mock')
    def test_data_content(self, **kwargs):
        current_time = datetime.now().__str__()
        url = "http://mapas.cultura.gov.br/api/"

        result = {
            'None': 1,
        }

        kwargs['mock'].get(url + "agent/find/", text=json.dumps(result))

        request_agents_raw_data = RequestAgentsRawData(current_time, url)
        agents_raw_data = request_agents_raw_data.data
        type_agents_raw_data = type(agents_raw_data)
        empty_list = {}
        assert type_agents_raw_data == type(empty_list)

    @requests_mock.Mocker(kw='mock')
    def test_data_lenght(self, **kwargs):
        current_time = datetime.now().__str__()
        url = "http://mapas.cultura.gov.br/api/"

        result = {
            'None': 1,
        }

        kwargs['mock'].get(url + "agent/find/", text=json.dumps(result))

        request_agents_raw_data = RequestAgentsRawData(current_time, url)
        agents_raw_data = request_agents_raw_data.data_length
        type_agents_raw_data = type(agents_raw_data)
        intenger = 1
        assert type_agents_raw_data == type(intenger)


class TestPercentAgentsPerAreaOperation(object):

    @staticmethod
    def test_total_agents_area_oreration():
        PercentAgentsPerAreaOperation.drop_collection()
        agent_indicator = PercentAgentsPerAreaOperation(
            50, datetime.now().__str__(), {"area": 10})
        agent_indicator.save()
        query = PercentAgentsPerAreaOperation.objects.first()
        assert query.total_agents_area_oreration == {"area": 10}


#========== New testes =============

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

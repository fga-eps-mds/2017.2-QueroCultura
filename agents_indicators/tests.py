from datetime import datetime
from .api_connection import RequestAgentsRawData
from .models import PercentIndividualAndCollectiveAgent
from .models import AmountAgentsRegisteredPerYear
from .models import AmountAgentsRegisteredPerMonth
from .models import PercentAgentsPerAreaOperation


class TestAmountAgentsRegisteredPerMonth(object):

    @staticmethod
    def total_agents_registered_mounth():
        AmountAgentsRegisteredPerMonth.drop_collection()
        agents_in_year = AmountAgentsRegisteredPerYear(10, datetime.now())
        agents_in_year.save()
        query = AmountAgentsRegisteredPerMonth.object.first()
        assert query._total_agents_registered_year == 10


class TestAmountAgentsRegisteredPerYear(object):
    @staticmethod
    def total_agents_registered_year():
        AmountAgentsRegisteredPerYear.drop_collection()
        agents_in_year = AmountAgentsRegisteredPerYear(10, datetime.now())
        agents_in_year.save()
        query = AmountAgentsRegisteredPerYear.object.first()
        assert query._total_agents_registered_year == 10


class TestPercentIndividualAndCollectiveAgent(object):

    @staticmethod
    def test_total_agents():
        PercentIndividualAndCollectiveAgent.drop_collection()
        agent_indicator = PercentIndividualAndCollectiveAgent(50, datetime.now(), 10, 10)
        agent_indicator.save()
        query = PercentIndividualAndCollectiveAgent.objects.first()
        assert query._total_agents == 50

    @staticmethod
    def test_total_individual_agent():
        PercentIndividualAndCollectiveAgent.drop_collection()
        agent_indicator = PercentIndividualAndCollectiveAgent(50, datetime.now(), 10, 10)
        agent_indicator.save()
        query = PercentIndividualAndCollectiveAgent.objects.first()
        assert query._total_individual_agent == 10

    @staticmethod
    def test_total_collective_agent():
        PercentIndividualAndCollectiveAgent.drop_collection()
        agent_indicator = PercentIndividualAndCollectiveAgent(50, datetime.now(), 10, 10)
        agent_indicator.save()
        query = PercentIndividualAndCollectiveAgent.objects.first()
        assert query._total_collective_agent == 10


class TestRequestAgentsRawData(object):

    @staticmethod
    def test_success_request():
        current_time = datetime.now().__str__()
        url = 'http://mapas.cultura.gov.br/api/agent/find/'
        request_agents_raw_data = RequestAgentsRawData(current_time, url)
        response_agents_raw_data = request_agents_raw_data.response
        response_status_code = response_agents_raw_data.status_code
        assert response_status_code == 200

    @staticmethod
    def test_data_content():
        current_time = datetime.now().__str__()
        url = 'http://mapas.cultura.gov.br/api/agent/find/'
        request_agents_raw_data = RequestAgentsRawData(current_time, url)
        agents_raw_data = request_agents_raw_data.data
        type_agents_raw_data = type(agents_raw_data)
        empty_list = []
        assert type_agents_raw_data == type(empty_list)

    @staticmethod
    def test_data_lenght():
        current_time = datetime.now().__str__()
        url = "http://mapas.cultura.gov.br/api/agent/find/"
        request_agents_raw_data = RequestAgentsRawData(current_time, url)
        agents_raw_data = request_agents_raw_data.data_length
        type_agents_raw_data = type(agents_raw_data)
        intenger = 1
        assert type_agents_raw_data == type(intenger)

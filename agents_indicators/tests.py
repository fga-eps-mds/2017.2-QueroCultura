from datetime import datetime
from .api_connections import RequestAgentsRawData


class TestClassRequestAgentsRawData(object):

    def test_success_request(self):
        current_time = datetime.now().__str__()
        request_agents_raw_data = RequestAgentsRawData(current_time)
        response_agents_raw_data = request_agents_raw_data.response
        response_status_code = response_agents_raw_data.status_code
        assert response_status_code == 200

    def test_data_content(self):
        current_time = datetime.now().__str__()
        request_agents_raw_data = RequestAgentsRawData(current_time)
        agents_raw_data = request_agents_raw_data.data
        type_agents_raw_data = type(agents_raw_data)
        empty_list = []
        assert type_agents_raw_data == type(empty_list)

    def test_data_lenght(self):
        current_time = datetime.now().__str__()
        request_agents_raw_data = RequestAgentsRawData(current_time)
        agents_raw_data = request_agents_raw_data.data_length
        type_agents_raw_data = type(agents_raw_data)
        intenger = 1
        assert type_agents_raw_data == type(intenger)

def test_data_lenght():
    current_time = datetime.now().__str__()
    request_agents_raw_data = RequestAgentsRawData(current_time)
    agents_raw_data = request_agents_raw_data.data_length
    type_agents_raw_data = type(agents_raw_data)
    integer = 1
    assert type_agents_raw_data == type(integer)

from datetime import datetime
from .api_connections import RequestSpacesRawData


class TestClassRequestSpacesRawData(object):

    def test_success_request(self):
        current_time = datetime.now().__str__()
        request_space_raw_data = RequestSpacesRawData(current_time)
        response_space_raw_data = request_space_raw_data.response
        response_status_code = response_space_raw_data.status_code
        assert response_status_code == 200

    def test_data_content(self):
        current_time = datetime.now().__str__()
        request_space_raw_data = RequestSpacesRawData(current_time)
        space_raw_data = request_space_raw_data.data
        type_space_raw_data = type(space_raw_data)
        empty_list = []
        assert type_space_raw_data == type(empty_list)

    def test_data_lenght(self):
        current_time = datetime.now().__str__()
        request_space_raw_data = RequestSpacesRawData(current_time)
        space_raw_data = request_space_raw_data.data_length
        type_space_raw_data = type(space_raw_data)
        intenger = 1
        assert type_space_raw_data == type(intenger)

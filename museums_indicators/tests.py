from datetime import datetime
from .api_connections import RequestMuseumRawData


class TestClassRequestMuseumsRawData(object):

    def test_success_request(self):
        current_time = datetime.now().__str__()
        request_museum_raw_data = RequestMuseumRawData(current_time)
        response_museum_raw_data = request_museum_raw_data.response
        response_status_code = response_museum_raw_data.status_code
        assert response_status_code == 200

    def test_data_content(self):
        current_time = datetime.now().__str__()
        request_museum_raw_data = RequestMuseumRawData(current_time)
        museum_raw_data = request_museum_raw_data.data
        type_museum_raw_data = type(museum_raw_data)
        empty_list = []
        assert type_museum_raw_data == type(empty_list)

    def test_data_lenght(self):
        current_time = datetime.now().__str__()
        request_museum_raw_data = RequestMuseumRawData(current_time)
        museum_raw_data = request_museum_raw_data.data_length
        type_museum_raw_data = type(museum_raw_data)
        intenger = 1
        assert type_museum_raw_data == type(intenger)

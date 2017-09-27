from datetime import datetime
from .api_connections import RequestMixedIndicatorsRawData


def test_success_request():
    current_time = datetime.now().__str__()
    request_mixed_raw_data = RequestMixedIndicatorsRawData(current_time)
    response_mixed_raw_data = request_mixed_raw_data.response
    response_status_code = response_mixed_raw_data.status_code
    assert response_status_code == 200


def test_data_content():
    current_time = datetime.now().__str__()
    request_mixed_raw_data = RequestMixedIndicatorsRawData(current_time)
    mixed_raw_data = request_mixed_raw_data.data
    type_mixed_raw_data = type(mixed_raw_data)
    empty_list = []
    assert type_mixed_raw_data == type(empty_list)


def test_data_lenght():
    current_time = datetime.now().__str__()
    request_mixed_raw_data = RequestMixedIndicatorsRawData(current_time)
    mixed_raw_data = request_mixed_raw_data.data_length
    type_mixed_raw_data = type(mixed_raw_data)
    intenger = 1
    assert type_mixed_raw_data == type(intenger)

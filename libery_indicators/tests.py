from datetime import datetime
from .api_connections import RequestLibraryRawData


def test_success_request():
    current_time = datetime.now().__str__()
    request_library_raw_data = RequestLibraryRawData(current_time)
    response_library_raw_data = request_library_raw_data.response
    response_status_code = response_library_raw_data.status_code
    assert response_status_code == 200


def test_data_content():
    current_time = datetime.now().__str__()
    request_museum_raw_data = RequestLibraryRawData(current_time)
    library_raw_data = request_museum_raw_data.data
    type_library_raw_data = type(library_raw_data)
    empty_list = []
    assert type_library_raw_data == type(empty_list)


def test_data_lenght():
    current_time = datetime.now().__str__()
    request_library_raw_data = RequestLibraryRawData(current_time)
    library_raw_data = request_library_raw_data.data_length
    type_library_raw_data = type(library_raw_data)
    intenger = 1
    assert type_library_raw_data == type(intenger)

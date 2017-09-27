from datetime import datetime
from .api_connections import RequestProjectsRawData


def test_success_request():
    current_time = datetime.now().__str__()
    request_projects_raw_data = RequestProjectsRawData(current_time)
    response_projects_raw_data = request_projects_raw_data.response
    response_status_code = response_projects_raw_data.status_code
    assert response_status_code == 200


def test_data_content():
    current_time = datetime.now().__str__()
    request_projects_raw_data = RequestProjectsRawData(current_time)
    projects_raw_data = request_projects_raw_data.data
    type_projects_raw_data = type(projects_raw_data)
    empty_list = []
    assert type_projects_raw_data == type(empty_list)


def test_data_lenght():
    current_time = datetime.now().__str__()
    request_projects_raw_data = RequestProjectsRawData(current_time)
    projects_raw_data = request_projects_raw_data.data_length
    type_projects_raw_data = type(projects_raw_data)
    intenger = 1
    assert type_projects_raw_data == type(intenger)
